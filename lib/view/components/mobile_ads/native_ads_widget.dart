import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdsWidget extends StatefulWidget {
  final String adsCode;
  final bool isSmallAds;
  final double cornerRadius;
  const NativeAdsWidget({super.key, this.isSmallAds = true, this.cornerRadius = 20.0, required this.adsCode});

  @override
  State<NativeAdsWidget> createState() => _NativeAdsWidgetState();
}

class _NativeAdsWidgetState extends State<NativeAdsWidget> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  final double _adAspectRatioSmall = (91 / 355);
  final double _adAspectRatioMedium = (365 / 355);

  @override
  void initState() {
    super.initState();

    _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            if (_nativeAdIsLoaded && _nativeAd != null) ...[
              SizedBox(
                height: MediaQuery.of(context).size.width * (widget.isSmallAds == true ? _adAspectRatioSmall : _adAspectRatioMedium),
                width: MediaQuery.of(context).size.width,
                child: AdWidget(
                  ad: _nativeAd!,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  color: Colors.amber,
                  child: const Center(
                    child: Text("Ad",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
              )
            ]
          ],
        ),
      ],
    );
  }

  /// Loads a native ad.
  void _loadAd() {
    setState(() {
      _nativeAdIsLoaded = false;
    });
    _nativeAd = NativeAd(
      adUnitId: widget.adsCode,
      
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          // ignore: avoid_print
          debugPrint('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // ignore: avoid_print
          debugPrint('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdClicked: (ad) {},
        onAdImpression: (ad) {},
        onAdClosed: (ad) {},
        onAdOpened: (ad) {},
        onAdWillDismissScreen: (ad) {},
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        cornerRadius: widget.cornerRadius,
        // Required: Choose a template.
        templateType: (widget.isSmallAds == true ? TemplateType.small : TemplateType.medium),
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}
