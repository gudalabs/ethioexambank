import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/ads/ads_unit_id_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// Import the async package for using timers

import '../../../core/helper/ads/good_banner.dart';
import '../../../environment.dart';

class BannerAdsWidget extends StatefulWidget {
  const BannerAdsWidget({super.key});

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
  bool isAdLoaded = true; // Track whether to show or hide banner ads

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Environment.showBannerAds
        ? IntrinsicHeight(
            child: GoodBanner(
              adUnitId: AdUnitHelper.bannerAdUnitId!,
              adRequest: const AdRequest(),
              interval: Environment.hideHomeBannerAdsAfteraMiniutes * 60 * 1000, // min to milisec
              adSize: AdSize.banner,
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
