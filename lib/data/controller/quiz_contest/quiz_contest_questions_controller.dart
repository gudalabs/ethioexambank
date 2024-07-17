// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/model/quiz_contest/quiz_contest_questions_model.dart';
import 'package:quiz_lab/data/model/quiz_contest/quiz_result_model.dart';
import 'package:quiz_lab/data/repo/quiz_contest/quiz_contest_repo.dart';
import 'package:quiz_lab/environment.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

class QuizContestQuestionsController extends GetxController {
  QuizContestRepo quizContestRepo;

  QuizContestQuestionsController({
    required this.quizContestRepo,
  });

  String examStartTimes = "";

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

  bool loading = false;
  bool showaudienceVote = false;

  String quizInfoID = "";
  late int questionsIndex;
  String? title = "";
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

  getQuizContestQuestions() async {
    loading = true;
    update();

    ResponseModel getQuestionsModel = await quizContestRepo.getExamQuestionList(quizInfoID);

    if (getQuestionsModel.statusCode == 200) {
      examQuestionsList.clear();
      QuizContestQuestionsModel model = QuizContestQuestionsModel.fromJson(jsonDecode(getQuestionsModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Question>? examQuestion = model.data!.questions!;

        if (examQuestion.isNotEmpty) {
          examQuestionsList.addAll(examQuestion);
        }
        if (model.data != null) {
          examStartTimes = model.data!.contest!.examStartTime!;
        }
        timerDuration = int.parse(model.data!.contestAnsDuration.toString());

        // CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]); loading = false;
        update();
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);
        loading = false;
        update();
        //need to cheak error msg
      }
    } else {
      loading = false;
      update();
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

    String optionId = optionsList[optionIndex].id.toString();

    examQuestionsList[questionIndex].setSelectedOptionId(optionId);

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
    showaudienceVote = !showaudienceVote;
    if (audienceVote == true) {
      audiencevotes = "1";
    }
    update();
  }

  int flipQuestionsIndex = -1;
  flipQuiston(int questionIndex) {
    flipQuestionsIndex = flipQuestionsIndex;
    flipQuistions = !flipQuistions;
    if (flipQuistions == true) {
      flipQuistion = "1";
    }
    update();
    flipQuistions ? pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut) : null;
  }

  int timerDuration = Environment.battleQuizPerQuestionSecond;
  int countDownTimerIndex = -1;
  bool restartTimer = false;
  restartCountDownTimer(int questionIndex) {
    countDownTimerIndex = countDownTimerIndex;
    restartTimer = !restartTimer;
    if (restartTimer == true) {
      reset_timer = "1";
    }
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

    if (fiftyFifty == true) {
      fifty_fifty = "1";
    }
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
      String quizId = examQuestionsList[i].id.toString();
      String selectedOptionId = examQuestionsList[i].selectedOptionId.toString();
      params['question_id[$i]'] = quizId;
      debugPrint('quize id: $quizId');
      params['option_$quizId'] = selectedOptionId;
      debugPrint("option_$quizId");
    }

    debugPrint(params['option_']);
    params['quizInfo_id'] = quizInfoID.toString();
    params['fifty_fifty'] = fifty_fifty;
    params['audience_poll'] = audiencevotes;
    params['time_reset'] = reset_timer;
    params['flip_question'] = flipQuistion;

    ResponseModel submitModel = await quizContestRepo.submitAnswer(params);

    if (submitModel.statusCode == 200) {
      QuizResultResponseModel model = QuizResultResponseModel.fromJson(jsonDecode(submitModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        appreciation = model.message!.success!.first;
        totalQuestions = model.data!.totalQuestion.toString();
        correctAnswer = model.data!.correctAnswer.toString();
        wrongAnswer = model.data!.wrongAnswer.toString();
        totalCoin = model.data!.totalCoin.toString();
        winningCoin = model.data!.winingCoin.toString();
        countDownController.pause();
        Get.toNamed(RouteHelper.quizContestresultScreen, arguments: [
          examQuestionsList,
          appreciation,
          totalQuestions,
          correctAnswer,
          wrongAnswer,
          totalCoin,
          winningCoin,
        ])!
            .whenComplete(() {
          Get.offAllNamed(RouteHelper.bottomNavBarScreen);
        });

        // CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
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

  resetallLifelines() {
    showQuestions = false;
    audienceVote = false;
    tapAnswer = false;
    flipQuistions = false;
    update();
  }
}
