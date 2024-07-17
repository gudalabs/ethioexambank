import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/divider/custom_divider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../../core/helper/shared_preference_helper.dart';
import '../../../data/services/api_client.dart';

class OnBoardIntroScreen extends StatefulWidget {
  const OnBoardIntroScreen({super.key});

  @override
  State<OnBoardIntroScreen> createState() => _OnBoardIntroScreenState();
}

class _OnBoardIntroScreenState extends State<OnBoardIntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  var currentPageID = 0;

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      bodyPadding: const EdgeInsets.only(top: Dimensions.space200),
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      infiniteAutoScroll: false,
      skip: const Icon(Icons.skip_next),
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: Dimensions.space50),
            child: SvgPicture.asset(
              MyImages.appLogoSVG,
              height: Dimensions.space60,
            ),
          ),
        ),
      ),
      showSkipButton: false,
      dotsFlex: 1,
      showDoneButton: false,
      showBackButton: false,
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      showNextButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(Dimensions.space16),
      controlsPadding: kIsWeb ? const EdgeInsets.all(Dimensions.space12) : const EdgeInsets.fromLTRB(Dimensions.space8, Dimensions.space4, Dimensions.space8, Dimensions.space10),
      dotsDecorator: const DotsDecorator(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.space3))),
        activeColor: MyColor.primaryColor,
        size: Size(10.0, 5.0),
        color: MyColor.colorLightGrey,
        activeSize: Size(Dimensions.space22, Dimensions.space5),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.space3)),
        ),
      ),
      onChange: (v) {
        debugPrint("Page Key $v");
        setState(() {
          currentPageID = v;
        });
      },
      pages: [
        PageViewModel(
          title: MyStrings.onboardTitle1.tr,
          body: MyStrings.onboardDescription1,
          image: SvgPicture.asset(
            MyImages.onboard1SVG,
          ),
          decoration: PageDecoration(
            titleTextStyle: semiBoldMediumLarge.copyWith(fontSize: Dimensions.space20),
            titlePadding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyPadding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyTextStyle: regularLarge.copyWith(color: MyColor.textColor),
          ),
        ),
        PageViewModel(
          title: MyStrings.onboardTitle2.tr,
          body: MyStrings.onboardDescription2,
          image: SvgPicture.asset(
            MyImages.onboard3SVG,
          ),
          decoration: PageDecoration(
            titlePadding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyPadding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space15),
            titleTextStyle: semiBoldMediumLarge.copyWith(fontSize: Dimensions.space20),
            bodyTextStyle: regularLarge.copyWith(color: MyColor.textColor),
          ),
        ),
        PageViewModel(
          title: MyStrings.onboardTitle3.tr,
          body: MyStrings.onboardDescription3.tr,
          image: SvgPicture.asset(
            MyImages.onboard3SVG,
          ),
          decoration: PageDecoration(
            titlePadding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyPadding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space15),
            titleTextStyle: semiBoldMediumLarge.copyWith(fontSize: Dimensions.space20),
            bodyTextStyle: regularLarge.copyWith(color: MyColor.textColor),
          ),
        ),
      ],
      globalFooter: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25),
            child: RoundedButton(
                text: (currentPageID + 1) == introKey.currentState?.getPagesLength() ? MyStrings.getStarted.tr : MyStrings.next.tr,
                cornerRadius: Dimensions.space10,
                press: () async {
                  if (introKey.currentState!.getCurrentPage() + 1 == introKey.currentState!.getPagesLength()) {
                    await Get.find<ApiClient>().sharedPreferences.setBool(SharedPreferenceHelper.onboardKey, true).whenComplete(() {
                      Get.offAllNamed(RouteHelper.loginScreen);
                    });
                  } else {
                    introKey.currentState!.next();
                  }
                }),
          ),
          const SizedBox(height: Dimensions.space5),
          const CustomDivider(hascolor: false)
        ],
      ),
    );
  }
}
