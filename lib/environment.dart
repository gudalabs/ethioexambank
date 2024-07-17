class Environment {
/* ATTENTION Please update your desired data. */

  static const String appName = 'QUIZ LAB';
  static const String version = '1.0.0';

  // LOGIN AND REG PART
  static const int otpResendSecond = 120; //OTP RESEND second
  static const int defaultQuizTime = 40;
  static const String defaultCountryCode = 'BD'; //Default Country Code

  // QUIZ SECTION
  static const int battleQuizPerQuestionSecond = 60; //Change Battle question sec
  static const bool isShowQuestionPrefix = true;

  static const bool isShowAdsOnQuizScreen = false;
  static const bool isShowAdsOnReviewAnswerScreen = false;

  //APP ADS SETTINGS
  static const bool showBannerAds = true; // show Banner Ads
  static const int hideHomeBannerAdsAfteraMiniutes = 2; // Hide Home Banner Ads After 2 Min

  static const bool showInterstitialAds = true; // show interstitial Ads

  static const int interstitialAdsShowAfter = 5; // show ads after 5th time click

  static const bool showRewardlAds = true; // show interstitial Ads

  //Authentication
  static const bool disablePhoneAuth = false; // Set to true => to disable it.
  static const bool disableGoogle = false; // Set to true => to disable it.
}
