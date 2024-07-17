import 'package:flutter/material.dart';
import 'package:quiz_lab/view/screens/battle-quiz-section/quiz-screen-widgets/battle_quiz_questions_body_section.dart';
import 'package:get/get.dart';

import '../../../data/model/battle/battle_question_list.dart';
import '../../components/app-bar/custom_category_appbar.dart';

class BattleQuizQuestionsScreen extends StatefulWidget {
  const BattleQuizQuestionsScreen({super.key});

  @override
  State<BattleQuizQuestionsScreen> createState() => _BattleQuizQuestionsScreenState();
}

class _BattleQuizQuestionsScreenState extends State<BattleQuizQuestionsScreen> {
  final title = Get.arguments[0] as String;
  final List<BattleQuestion> qustionsList = Get.arguments[1] as List<BattleQuestion>;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomCategoryAppBar(title: title.toString().tr),
        body: BattleQuizQuestionsBodySection(
          qustionsList: qustionsList,
        ));
  }
}
