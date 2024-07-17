import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/environment.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/screens/general_quiz/quiz-questions/quiz-screen-widgets/quiz_questions_body_section.dart';
import 'package:get/get.dart';

import '../../../../data/controller/quiz_questions/quiz_questions_controller.dart';
import '../../../../data/repo/quiz_questions_repo/quiz_questions_repo.dart';
import '../../../../data/services/api_client.dart';
import '../../../components/mobile_ads/quiz_banner_ads_widget.dart';

class QuizQuestionsScreen extends StatefulWidget {
  const QuizQuestionsScreen({super.key});

  @override
  State<QuizQuestionsScreen> createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
  var title = '';


  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(QuizquestionsRepo(apiClient: Get.find()));

    QuizQuestionsController controller = Get.put(QuizQuestionsController(quizquestionsRepo: Get.find()));
    controller.quizInfoID = Get.arguments[1];

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        title = Get.arguments[0] as String;
      });
      controller.getData(controller.quizInfoID.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: title.toString().tr),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          QuizBodySection(),
          Visibility(
            visible: Environment.isShowAdsOnQuizScreen,
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
