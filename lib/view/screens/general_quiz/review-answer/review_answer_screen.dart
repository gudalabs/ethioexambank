import 'package:flutter/material.dart';
import 'package:quiz_lab/environment.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../components/mobile_ads/quiz_banner_ads_widget.dart';
import 'review-answer-screen-widgets/review_answer_section.dart';

class ReviewAnswerScreen extends StatefulWidget {
  const ReviewAnswerScreen({super.key});

  @override
  State<ReviewAnswerScreen> createState() => _ReviewAnswerScreenState();
}

class _ReviewAnswerScreenState extends State<ReviewAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer.tr),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          ReviewAnswerSection(),
          Visibility(
            visible: Environment.isShowAdsOnReviewAnswerScreen,
            child: Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(bottom: Dimensions.space10),
                  child: QuizBannerAdsWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
