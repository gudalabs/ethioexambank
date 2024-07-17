import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/data/services/api_client.dart';

class AdUnitHelper {
  static ApiClient apiClient = ApiClient(sharedPreferences: Get.find());
  static String? bannerAdUnitId;
  static String? bannerAdUnitShow;
  static String? nativeBannerAdUnitId;
  static String? nativeBannerAdShow;
  static String? interstitialAdUnitId;
  static String? interstitialAdUnitShow;
  static String? rewardedAdUnitId;
  static String? rewardedAdUnitShow;

  static Future<void> fetchAdUnitIdsFromApi() async {
    try {
      bannerAdUnitShow = apiClient.getGSData().data?.generalSetting?.bannerAdsStatus;
      interstitialAdUnitShow = apiClient.getGSData().data?.generalSetting?.interstitialUnitStatus;
      rewardedAdUnitShow = apiClient.getGSData().data?.generalSetting?.rewardedUnitStatus;
      if (Platform.isAndroid) {
        bannerAdUnitId = apiClient.getGSData().data?.generalSetting?.bannerAdsId;
        
        nativeBannerAdUnitId = 'ca-app-pub-3940256099942544/2247696110';
        interstitialAdUnitId = apiClient.getGSData().data?.generalSetting?.interstitialUnitId;
        rewardedAdUnitId = apiClient.getGSData().data?.generalSetting?.rewardedUnitId;
      } else if (Platform.isIOS) {
        bannerAdUnitId = apiClient.getGSData().data?.generalSetting?.iosBannerAdsId;
        nativeBannerAdUnitId = 'ca-app-pub-3940256099942544/3986624511';
        interstitialAdUnitId = apiClient.getGSData().data?.generalSetting?.iosInterstitialUnitId;
        rewardedAdUnitId = apiClient.getGSData().data?.generalSetting?.iosRewardedUnitId;
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching ad unit IDs: $e');
      }
    }
  }

  // Call this function to initialize ad unit IDs from the API.
  static Future<void> initializeAdUnits() async {
    if (kDebugMode) {
      print("initializeAdUnits called");
    }
    await fetchAdUnitIdsFromApi();
  }
}
