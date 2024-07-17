// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/data/model/exam_zone/exam_result_model.dart';

import 'package:quiz_lab/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../core/route/route.dart';
import '../../model/dashboard/exam.dart';
import '../../model/exam_zone/exam_zone_question_list_model.dart';

class ExamZoneQuizController extends GetxController {
  ExamZoneRepo examZoneRepo;

  ExamZoneQuizController({
    required this.examZoneRepo,
  });

  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;
  bool flipQuistions = false;

  bool examNotStartYet = false;
  bool examAlreadyGiven = false;
  bool examFinished = false;
  bool examStarted = false;

  String flipQuistion = "0";
  String fifty_fifty = "0";
  String audiencevotes = "0";
  String reset_timer = "0";

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;

  int currentQuestionIndex = 0;

  bool loading = true;

  String? quizInfoID;
  late int questionsIndex;
  Exams examFullInfoData = Exams();
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

//Get Exam Questions

  Future getExamZoneQuestions(String quizInfoId, enterExamKey) async {
    loading = true;
    update();

    ResponseModel getQuestionsModel = await examZoneRepo.getExamQuestionList(quizInfoId, enterExamKey);

    if (getQuestionsModel.statusCode == 200) {
      examQuestionsList.clear();
      ExamZoneQuestionsModel model = ExamZoneQuestionsModel.fromJson(jsonDecode(getQuestionsModel.responseJson));
      // model.data.exam.examDuration
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        if (model.message!.success!.first.contains("start soon")) {
          examNotStartYet = true;
          loading = false;
          update();
          CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
        } else if (model.message!.success!.first.contains("already finished")) {
          examAlreadyGiven = true;
          loading = false;
          update();
          CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
        } else if (model.message!.success!.first.contains("closed")) {
          examFinished = true;
          loading = false;
          update();
          CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
        } else {
          examStarted = true;
          examFullInfoData = model.data!.exam!;
          List<Question>? examQuestion = model.data!.questions!;

          if (examQuestion.isNotEmpty) {
            examQuestionsList.addAll(examQuestion);
          }
          update();
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);

        //need to cheak error msg
      }
    } else {
      CustomSnackBar.error(errorList: [getQuestionsModel.message]);
    }

    loading = false;
    update();
  }

  showQuestion() {
    showQuestions = !showQuestions;
  }

  int remainingTime = 30;

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

  int timerDuration = 20;
  int countDownTimerIndex = -1;
  bool restartTimer = false;
  restartCountDownTimer(int questionIndex) {
    countDownTimerIndex = countDownTimerIndex;
    restartTimer = !restartTimer;
    update();
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
    params['quizInfo_id'] = quizInfoID.toString();
    params['fifty_fifty'] = fifty_fifty;
    params['audience_poll'] = audiencevotes;
    params['time_reset'] = reset_timer;
    params['flip_question'] = flipQuistion;

    ResponseModel submitModel = await examZoneRepo.submitAnswer(params);

    if (submitModel.statusCode == 200) {
      ExamResultModel model = ExamResultModel.fromJson(jsonDecode(submitModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        appreciation = model.message!.success!.first;
        totalQuestions = model.data!.totalQuestion.toString();
        correctAnswer = model.data!.correctAnswer.toString();
        wrongAnswer = model.data!.wrongAnswer.toString();
        totalCoin = model.data!.totalCoin.toString();
        winningCoin = model.data!.winingCoin.toString();

        Get.toNamed(RouteHelper.examZoneResultScreen, arguments: MyStrings.quizResult.tr)!.whenComplete(() {
          Get.offAllNamed(RouteHelper.bottomNavBarScreen);
        });
        // CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);

        submitLoading = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [submitModel.message]);
      submitLoading = false;
      update();
    }

    submitLoading = false;
    update();
  }

  resetallLifelines() {
    showQuestions = false;
    audienceVote = false;
    tapAnswer = false;
    flipQuistions = false;
    update();
  }
}
