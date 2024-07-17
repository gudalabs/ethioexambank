import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/helper/ads/admob_helper.dart';
import '../../../../../core/utils/my_images.dart';
import 'widgets/fun_n_learn_result_body_section.dart';

class FunNlearnResultScreen extends StatefulWidget {
  const FunNlearnResultScreen({super.key});

  @override
  State<FunNlearnResultScreen> createState() => _FunNlearnResultScreenState();
}

class _FunNlearnResultScreenState extends State<FunNlearnResultScreen> {
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
      appBar: CustomCategoryAppBar(title: MyStrings.quizResult.tr),
      body: Stack(
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
              child: FunNLearnResultBodySection(), // Your existing content
            ),
          ),
        ],
      ),
    );
  }
}
