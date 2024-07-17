import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';

import '../../../../core/helper/ads/admob_helper.dart';
import '../../guess_the_word/result/widget/result_body.dart';

class GuessWordResultScreen extends StatefulWidget {
  const GuessWordResultScreen({super.key});

  @override
  State<GuessWordResultScreen> createState() => _GuessWordResultScreenState();
}

class _GuessWordResultScreenState extends State<GuessWordResultScreen> {
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
        appBar: CustomCategoryAppBar(
          title: MyStrings.quizResult.tr,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: Dimensions.screenPaddingHV,
            child: GetBuilder<GuessTheWordController>(builder: (controller) {
              return controller.isLoading ? const CustomLoader() : const GuessResultBody();
            }),
          ),
        ));
  }
}
