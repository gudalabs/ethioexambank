import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../environment.dart';
import 'ads_unit_id_helper.dart';
import 'good_interstitial.dart';

class AdmobHelper {
  static final AdmobHelper _instance = AdmobHelper._internal();
  factory AdmobHelper() => _instance;

  AdmobHelper._internal();

  InterstitialAd? _interstitialAd;
  late GoodInterstitial goodInterstitialAd;
  InterstitialAd get interstitialAd => _interstitialAd!;
  int _counter = 0;

  // Banner Ads
  static BannerAd getBannerAd() {
    BannerAd? bAd;
    if (AdUnitHelper.bannerAdUnitId != null) {
      bAd = BannerAd(
          size: AdSize.banner,
          adUnitId: AdUnitHelper.bannerAdUnitId!,
          listener: BannerAdListener(onAdClosed: (Ad ad) {
            debugPrint("Ad Closed");
          }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          }, onAdLoaded: (Ad ad) {
            debugPrint('Ad Loaded');
          }, onAdOpened: (Ad ad) {
            debugPrint('Ad opened');
          }),
          request: const AdRequest());

      return bAd;
    }
    return bAd!;
  }

  // Native Banner Ads
  static NativeAd getNativeBannerAd() {
    NativeAd? nativeBAd;
    if (AdUnitHelper.bannerAdUnitId != null) {
      nativeBAd = NativeAd(
        adUnitId: AdUnitHelper.nativeBannerAdUnitId!,
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('$NativeAd loaded.');
            // setState(() {
            //   _nativeAdIsLoaded = true;
            // });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('$NativeAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => debugPrint('$NativeAd onAdOpened.'),
          onAdClosed: (Ad ad) => debugPrint('$NativeAd onAdClosed.'),
        ),
        nativeTemplateStyle: NativeTemplateStyle(
          templateType: TemplateType.medium,
          mainBackgroundColor: Colors.white12,
          callToActionTextStyle: NativeTemplateTextStyle(
            size: 16.0,
          ),
          primaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black38,
            backgroundColor: Colors.white70,
          ),
        ),
      );
      return nativeBAd;
    }
    return nativeBAd!;
  }

  // create interstitial ads
  void createInterstitialAd() {
    if (Environment.showInterstitialAds == true) {
      if (AdUnitHelper.interstitialAdUnitShow! == '1') {
        goodInterstitialAd = GoodInterstitial(
          adUnitId: AdUnitHelper.interstitialAdUnitId!,
          adRequest: AdRequest(),
          interval: 0,
        );
      }
    }
  }

  void showGoodInterstitialAds() {
    _counter++;
    if (_counter % Environment.interstitialAdsShowAfter == 0) {
      if (kDebugMode) {
        print("Good InterstialAds Show now  $_counter");
      }
      goodInterstitialAd.show(reloadAfterShow: true);
    }
    print("Good InterstialAds Show count $_counter");
  }

  void showInterstitialAd() {
    debugPrint(_counter.toString());
    if (Environment.showInterstitialAds == true && AdUnitHelper.interstitialAdUnitShow.toString() == '1') {
      showGoodInterstitialAds();
    }
  }

  void loadRewardAdAlways() {
    if (Environment.showRewardlAds == true && AdUnitHelper.rewardedAdUnitShow == '1') {
      if (AdUnitHelper.rewardedAdUnitId != null) {
        RewardedAd.load(
          adUnitId: AdUnitHelper.rewardedAdUnitId!,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
            // Called when an ad is successfully received.
            onAdLoaded: (ad) {
              ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {},
              );

              debugPrint('$ad loaded.');
              // Keep a reference to the ad so you can show it later.

              ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
                debugPrint("You Get ${rewardItem.amount}");
                // Reward the user for watching an ad.
              });
            },
            // Called when an ad request failed.
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('RewardedAd failed to load: $error');
            },
          )
        );
      }
    }
  }
}