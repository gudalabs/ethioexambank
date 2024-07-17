import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_lab/core/helper/ads/good_ads_helpers.dart';

class GoodInterstitial {
  static final Map<String, InterstitialAd> _instance = {};
  static final Map<String, int> _interval = {};
  static final Map<String, bool> _reloadAfterShow = {};

  /// [interval] minimum interval between 2 impressions (millis), default: 60000
  const GoodInterstitial({
    required this.adUnitId,
    this.adRequest = const AdRequest(),
    this.interval = 60000,
  });

  final String adUnitId;
  final AdRequest adRequest;
  final int interval;

  Future<bool> load() async {
    _interval[adUnitId] = interval;
    final Completer<bool> result = Completer();
    await InterstitialAd.load(
      adUnitId: adUnitId,
      request: adRequest,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) => debugPrint('interstitial_showedFullScreenContent($adUnitId): ${ad.print()}'),
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              debugPrint('interstitial_dismissedFullScreenContent($adUnitId): ${ad.print()}');
              ad.dispose();
              _instance.remove(adUnitId);
              if (_reloadAfterShow[adUnitId] ?? true) {
                load();
              }
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              debugPrint('interstitial_failedToShowFullScreenContent($adUnitId): ${ad.print()},Error: $error');
              ad.dispose();
              _instance.remove(adUnitId);
              if (_reloadAfterShow[adUnitId] ?? true) {
                load();
              }
            },
            onAdImpression: (InterstitialAd ad) => debugPrint('interstitial_impression($adUnitId): ${ad.print()}'),
          );
          _instance[adUnitId] = ad;
          debugPrint('interstitial_loaded($adUnitId): ${ad.print()}');
          result.complete(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _instance.remove(adUnitId);
          result.complete(false);
        },
      ),
    );
    return result.future;
  }

  /// show the InterstitialAd by [adUnitId], must call [load] first.
  ///
  /// if [reloadAfterShow] is true, it will automatically call reload for
  /// you after show. default: true
  Future<void> show({
    bool reloadAfterShow = true,
  }) async {
    _reloadAfterShow[adUnitId] = reloadAfterShow;
    // Ad instance of adUnitId has loaded fail or already showed.
    if (_instance[adUnitId] == null) {
      if (reloadAfterShow) {
        load();
      }
      return;
    }
    if (DateTime.now().millisecondsSinceEpoch - await getLastImpressions(adUnitId) > _interval.get(adUnitId)) {
      await _instance[adUnitId]!.show();
      await setLastImpressions(adUnitId, DateTime.now().millisecondsSinceEpoch);
    }
  }
}
