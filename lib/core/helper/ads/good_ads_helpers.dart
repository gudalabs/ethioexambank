import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setLastImpressions(String adUnitId, int time) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.setInt(adUnitId, time);
}

Future<int> getLastImpressions(String adUnitId) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(adUnitId) ?? 0;
}

extension OnMapInt on Map<String, int> {
  int get(String id) {
    return this[id] ?? 0;
  }

  void set(String id, int value) {
    this[id] = value;
  }
}

extension PrintInterstitial on InterstitialAd {
  String print() {
    return responseInfo.toString();
  }
}

extension PrintRewardedAd on RewardedAd {
  String print() {
    return responseInfo.toString();
  }
}
