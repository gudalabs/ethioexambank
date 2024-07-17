import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/ads/ads_unit_id_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../environment.dart';

class QuizBannerAdsWidget extends StatefulWidget {
  const QuizBannerAdsWidget({super.key});

  @override
  State<QuizBannerAdsWidget> createState() => _QuizBannerAdsWidgetState();
}

class _QuizBannerAdsWidgetState extends State<QuizBannerAdsWidget> {
  BannerAd? _bannerAd;
  bool isAdLoaded = true;
  @override
  void initState() {
    super.initState();
    if (AdUnitHelper.bannerAdUnitId != null) {
      if (Environment.showBannerAds && AdUnitHelper.bannerAdUnitShow! == '1') {
        loadAds();
        _bannerAd!.load();
      } else {
        _bannerAd!.dispose();
      }
    }
  }

  loadAds() {
    try {
      _bannerAd = BannerAd(
        adUnitId: AdUnitHelper.bannerAdUnitId!,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            setState(() {
              isAdLoaded = true;
            });
            debugPrint('$BannerAd loaded.');
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('$BannerAd failedToLoad: $error');

            print('BannerAd failedToLoad: $error');
            _bannerAd?.dispose();
            _bannerAd = null;
            loadAds();
          },
          onAdOpened: (Ad ad) => debugPrint('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => debugPrint('$BannerAd onAdClosed.'),
          onAdWillDismissScreen: (Ad ad) => debugPrint('$BannerAd onAdWillDismissScreen.'),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: _bannerAd!);
    return Environment.showBannerAds && AdUnitHelper.bannerAdUnitShow! == '1' && isAdLoaded
        ? Container(
            alignment: Alignment.center,
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: adWidget,
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd!.dispose();
    _bannerAd = null;
  }
}
