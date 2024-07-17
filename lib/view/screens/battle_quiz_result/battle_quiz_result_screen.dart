import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/helper/ads/admob_helper.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/my_strings.dart';
import '../../components/app-bar/custom_category_appbar.dart';
import 'widgets/battle_quiz_result_body_section.dart';

class BattleQuizResultScreen extends StatefulWidget {
  const BattleQuizResultScreen({super.key});

  @override
  State<BattleQuizResultScreen> createState() => _BattleQuizResultScreenState();
}

class _BattleQuizResultScreenState extends State<BattleQuizResultScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // AdmobHelper().loadInterstitialAdAlways();
      AdmobHelper().loadRewardAdAlways();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      appBar: CustomCategoryAppBar(
        title: MyStrings.battleResult.tr,
        systemUiOverlayStyle: SystemUiOverlayStyle(statusBarColor: MyColor.colorWhite, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: MyColor.getPrimaryColor(), systemNavigationBarIconBrightness: Brightness.light),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(RouteHelper.bottomNavBarScreen);
          return false;
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                MyImages.reviewBgImage,

                fit: BoxFit.cover, // Make the image cover the full width
              ),
            ),

            /// Background image
            const SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.space15,
                  vertical: Dimensions.space50,
                ),
                child: BattleQuizResultBodySection(), // Your existing content
              ),
            ),
          ],
        ),
      ),
    );
  }
}
