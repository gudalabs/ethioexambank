import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/screens/quiz_contest/review-answer/widget/review_answer_section.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../environment.dart';
import '../../../components/mobile_ads/quiz_banner_ads_widget.dart';

class QuizContestReviewAnswerScreen extends StatefulWidget {
  const QuizContestReviewAnswerScreen({super.key});

  @override
  State<QuizContestReviewAnswerScreen> createState() => _QuizContestReviewAnswerScreenState();
}

class _QuizContestReviewAnswerScreenState extends State<QuizContestReviewAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer.tr),
        body: const Stack(
          fit: StackFit.expand,
          children: [
            QuizContestReviewAnswerSection(),
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
        ));
  }
}
