// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/data/model/play_different_quizes/daily_quiz/daily_quiz_questions_model.dart';

import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../../core/route/route.dart';
import '../../../model/dashboard/dashboard_model.dart';
import '../../../model/dashboard/exam.dart';
import '../../../model/play_different_quizes/daily_quiz/daily_quiz_submit_answer_model.dart';
import '../../../repo/play_different_quizes/daily_quiz/daily_quiz_repo.dart';

class DailyQuizQuestionsController extends GetxController {
  DailyQuizRepo dailyQuizRepo;

  DailyQuizQuestionsController({
    required this.dailyQuizRepo,
  });

  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;
  bool flipQuistions = false;
  String flipQuistion = "0";
  String fifty_fifty = "0";
  String audiencevotes = "0";
  String reset_timer = "0";

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;

  int currentQuestionIndex = 0;

  bool loading = true;
  bool alreadyPlayed = false;

  String? quizInfoID;
  String? title;
  late int questionsIndex;
  List<Exams> examcategoryList = [];
  List<Question> examQuestionsList = [];
  List<Option> optionsList = [];

  List selectedQuestionsId = [];
  List selectedAnswerId = [];

  late final TabController tabController;
  int selectedIndex = 1;

  CountDownController countDownController = CountDownController();
  PageController pageController = PageController();
  PageController reviewPageController = PageController();
  int currentPage = 0;

  changePage(int page) {
    currentPage = page;
    update();
  }

  String enterExamKey = "";
  String quizInfoId = "";

  TextEditingController enterExamKeys = TextEditingController();

  getDailyQuizQuestions() async {
    loading = true;
    update();

    ResponseModel getQuestionsModel = await dailyQuizRepo.getDailyQuestions();

    if (getQuestionsModel.statusCode == 200) {
      examQuestionsList.clear();

      DailyQuizQuestionsModel model = DailyQuizQuestionsModel.fromJson(jsonDecode(getQuestionsModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        debugPrint("get answer done");
        // debugPrint(model.data);
        quizInfoId = model.data!.dailyQuiz!.id.toString();
        update();

        List<Question>? examQuestion = model.data!.questions!;

        if (examQuestion.isNotEmpty) {
          examQuestionsList.addAll(examQuestion);
        }

        // CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
      } else {
        if (model.message!.error!.first.contains("already played")) {
          alreadyPlayed = true;
        }
        CustomSnackBar.error(errorList: model.message!.error!);

        //need to cheak error msg
      }
    } else {
      CustomSnackBar.error(errorList: [getQuestionsModel.message]);
    }
    debugPrint("this is ${getQuestionsModel.message}");

    loading = false;
    update();
  }

  showQuestion() {
    showQuestions = !showQuestions;
  }

  int timerDuration = 20;
  int countDownTimerIndex = -1;
  bool restartTimer = false;
  restartCountDownTimer(int questionIndex) {
    countDownTimerIndex = countDownTimerIndex;
    restartTimer = !restartTimer;
    update();
  }

  int selectedOptionIndex = -1;
  selectAnswer(
    int optionIndex,
    int questionIndex,
  ) {
    selectedOptionIndex = optionIndex;
    debugPrint('work here');
    String optionId = optionsList[optionIndex].id.toString();

    debugPrint('not work here');
    examQuestionsList[questionIndex].setSelectedOptionId(optionId);

    debugPrint('done');

    update();
  }

  selectTab() {
    selectedIndex = tabController.index;
    update();
  }

  String questionId = "";
  String thisQuestionId = "";
  isValidAnswer(int index, int optionIndex) {
    questionId = examQuestionsList[index].selectedOptionId.toString();
    thisQuestionId = optionsList[optionIndex].id.toString();

    if (thisQuestionId == questionId && optionsList[optionIndex].isAnswer == '1') {
      return true;
    } else {
      return false;
    }
  }

  int audienceVoteIndex = -1;
  audienceVotes(int questionIndex) {
    audienceVoteIndex = questionIndex;
    audienceVote = !audienceVote;
    update();
  }

  int flipQuestionsIndex = -1;
  flipQuiston(int questionIndex) {
    flipQuestionsIndex = flipQuestionsIndex;
    flipQuistions = !flipQuistions;
    update();
    flipQuistions ? pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut) : null;
  }

  bool fiftyFifty = false;
  int fiftyFiftyIndex = -1;
  makeFiftyFifty(int index) {
    List<Option> allOptions = examQuestionsList[index].options!;
    var random = Random();
    Option correctAnswers = allOptions.firstWhere((element) => element.isAnswer == '1');
    allOptions.remove(correctAnswers);
    Option incorrectAnswer = allOptions[random.nextInt(allOptions.length)];
    List<Option> optionsToDisplay = [correctAnswers, incorrectAnswer]..shuffle(random);

    examQuestionsList[index].options!.clear();
    examQuestionsList[index].options!.addAll(optionsToDisplay);
    update();

    debugPrint("object is here");
    fiftyFiftyIndex = fiftyFiftyIndex;
    fiftyFifty = !fiftyFifty;
    update();
  }

  void setCurrentOption(int questionsIndex) {
    // optionsList.clear();

    if (examQuestionsList[questionsIndex].options != null) {
      optionsList = examQuestionsList[questionsIndex].options!;
    }
  }

  bool submitLoading = false;

  String totalQuestions = "";
  String correctAnswer = "";
  String wrongAnswer = "";
  String totalCoin = "";
  String winningCoin = "";
  String appreciation = "";

  submitAnswer() async {
    submitLoading = true;
    update();

    Map<String, dynamic> params = {};

    for (int i = 0; i < examQuestionsList.length; i++) {
      String quizeId = examQuestionsList[i].id.toString();
      String selectedOptionId = examQuestionsList[i].selectedOptionId.toString();
      params['question_id[$i]'] = quizeId;
      debugPrint('quize id: $quizeId');
      params['option_$quizeId'] = selectedOptionId;
      debugPrint("option_$quizeId");
    }
    debugPrint(params['option_']);
    params['quizInfo_id'] = quizInfoId.toString();
    params['fifty_fifty'] = fifty_fifty;
    params['audience_poll'] = audiencevotes;
    params['time_reset'] = reset_timer;
    params['flip_question'] = flipQuistion;

    ResponseModel submitModel = await dailyQuizRepo.submitAnswer(params);

    if (submitModel.statusCode == 200) {
      DailyQuizSubmitAnswerModel model = DailyQuizSubmitAnswerModel.fromJson(jsonDecode(submitModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        appreciation = model.message!.success!.first;
        totalQuestions = model.data!.totalQuestion.toString();
        correctAnswer = model.data!.correctAnswer.toString();
        wrongAnswer = model.data!.wrongAnswer.toString();
        totalCoin = model.data!.user!.coins.toString();
        winningCoin = model.data!.winingCoin.toString();
        countDownController.pause();
        Get.toNamed(RouteHelper.dailyQuizresultScreen, arguments: MyStrings.quizResult.tr)!.whenComplete(() {
          Get.back();
        });
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);

        //need to cheak error msg
      }
    } else {
      CustomSnackBar.error(errorList: [submitModel.message]);
    }
    debugPrint("this is ${submitModel.message}");
    debugPrint("this is $params");
    submitLoading = false;
    update();
  }
}
