// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_lab/core/helper/string_format_helper.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/data/model/quiz_questions_model/quiz_questions_model.dart';
import 'package:quiz_lab/data/model/submit_answer/submit_answer_model.dart';
import 'package:quiz_lab/data/repo/quiz_questions_repo/quiz_questions_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class QuizQuestionsController extends GetxController {
  QuizquestionsRepo quizquestionsRepo;

  QuizQuestionsController({required this.quizquestionsRepo});

  bool showQuestions = false;
  bool audienceVote = false;
  bool showaudienceVote = false;
  bool tapAnswer = false;
  bool flipQuistions = false;
  bool restartTimer = false;

  String flipQuistion = "0";
  String fifty_fifty = "0";
  String audiencevotes = "0";
  String reset_timer = "0";

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;
  int timerDuration = 20;

  int currentQuestionIndex = 0;

  bool isLoading = true;

  int? quizInfoID;
  late int questionsIndex;
  List<Question> questionsList = [];
  List<Option> optionsList = [];

  List selectedQuestionsId = [];
  List selectedAnswerId = [];

  CountDownController countDownController = CountDownController();
  PageController pageController = PageController();
  PageController reviewController = PageController();
  int currentPage = 0;

  changePage(int page) {
    currentPage = page;
    update();
  }

  String successmessage = "";

  void getData(String subcategoryId) async {
    isLoading = true;
    audienceVote = false;
    showQuestions = false;
    update();

    ResponseModel model = await quizquestionsRepo.getData(quizInfoID!);

    debugPrint("object$quizInfoID");

    if (model.statusCode == 200) {
      questionsList.clear();

      QuizQuestionsModel quizquestions = QuizQuestionsModel.fromJson(jsonDecode(model.responseJson));

      if (quizquestions.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Question>? subcategorylist = quizquestions.data?.questions;

        if (subcategorylist != null && subcategorylist.isNotEmpty) {
          questionsList.addAll(subcategorylist);
        }

        timerDuration = int.parse(quizquestions.data!.perQuestionAnswerDuration.toString());
        update();

        successmessage = quizquestions.message!.success.toString();
      } else {
        CustomSnackBar.error(errorList: [...quizquestions.message!.error!]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isLoading = false;
    update();
  }

  showQuestion() {
    showQuestions = !showQuestions;
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
    questionsList[questionIndex].setSelectedOptionId(optionId);

    debugPrint('done');

    update();
  }

  String questionId = "";
  String thisQuestionId = "";
  isValidAnswer(int index, int optionIndex) {
    questionId = questionsList[index].selectedOptionId.toString();
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

  String calculateAudienceVotes(String audience, String playedAudience) {
    double data = ((double.parse(audience) / double.parse(playedAudience)) * 100);
    return Converter.formatNumber(data.toString());
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

  int countDownTimerIndex = -1;
  restartCountDownTimer(int questionIndex) {
    countDownTimerIndex = countDownTimerIndex;
    restartTimer = !restartTimer;
    if (restartTimer == true) {
      reset_timer = "1";
    }
    update();
  }

  bool isFiftyFiftyAlreadyUsed = false;
  int fiftyFiftyIndex = -1;

  makeFiftyFifty(int index) {
    List<Option> allOptions = questionsList[index].options!;
    var random = Random();
    Option correctAnswers = allOptions.firstWhere((element) => element.isAnswer == '1');
    allOptions.remove(correctAnswers);
    Option incorrectAnswer = allOptions[random.nextInt(allOptions.length)];
    List<Option> optionsToDisplay = [correctAnswers, incorrectAnswer]..shuffle(random);

    questionsList[index].options!.clear();
    questionsList[index].options!.addAll(optionsToDisplay);
    update();

    fiftyFiftyIndex = fiftyFiftyIndex;
    isFiftyFiftyAlreadyUsed = !isFiftyFiftyAlreadyUsed;
    if (isFiftyFiftyAlreadyUsed == true) {
      fifty_fifty = "1";
    }
    update();
  }

  void setCurrentOption(int questionsIndex) {
    if (questionsList[questionsIndex].options != null) {
      optionsList = questionsList[questionsIndex].options!;
    }
  }

  bool submitLoading = false;

  String totalQuestions = "";
  String correctAnswer = "";
  String wrongAnswer = "";
  String totalCoin = "";
  String winningCoin = "";
  String appreciation = "";

  String nextlevelQuizInfoTitle = "";
  int nextlevelQuizInfoId = 0;

  submitAnswer() async {
    submitLoading = true;
    update();

    Map<String, dynamic> params = {};

    for (int i = 0; i < questionsList.length; i++) {
      String quizeId = questionsList[i].id.toString();
      String selectedOptionId = questionsList[i].selectedOptionId.toString();

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

    ResponseModel submitModel = await quizquestionsRepo.submitAnswer(params);

    if (submitModel.statusCode == 200) {
      SubmitAnswerModel model = SubmitAnswerModel.fromJson(jsonDecode(submitModel.responseJson));
      if (model.status.toLowerCase() == MyStrings.success.toLowerCase()) {
        appreciation = model.message.success!.first;
        totalQuestions = model.data.totalQuestion.toString();
        correctAnswer = model.data.correctAnswer.toString();
        wrongAnswer = model.data.wrongAnswer.toString();
        totalCoin = model.data.totalScore.toString();
        winningCoin = model.data.winingScore.toString();

        if (model.data.nextLevelQuizInfo != null) {
          nextlevelQuizInfoId = model.data.nextLevelQuizInfo!.id;
          if (model.data.nextLevelQuizInfo!.categoryId != null) {
            nextlevelQuizInfoTitle = model.data.nextLevelQuizInfo!.category!.name;
          }
          if (model.data.nextLevelQuizInfo!.subCategoryId != null) {
            nextlevelQuizInfoTitle = model.data.nextLevelQuizInfo!.subcategory!.name;
          }
        }
        countDownController.pause();
        Get.toNamed(RouteHelper.quizResultScreen)!.whenComplete(() {
          Get.back();
        });

        // CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
      } else {
        CustomSnackBar.error(errorList: model.message.error ?? [MyStrings.somethingWentWrong.tr]);

        //need to cheak error msg
      }
    } else {
      CustomSnackBar.error(errorList: [submitModel.message]);
    }

    submitLoading = false;
    update();
  }

  Future<void> resetAllDataController() async {
    // Clear data and reset controllers
    questionsList.clear();
    optionsList.clear();
    selectedQuestionsId.clear();
    selectedAnswerId.clear();
    currentPage = 0;
    selectedOptionIndex = -1;
    audienceVoteIndex = -1;
    flipQuestionsIndex = -1;
    countDownTimerIndex = -1;
    fiftyFiftyIndex = -1;
    audienceVote = false;
    showQuestions = false;
    flipQuistions = false;
    restartTimer = false;
    successmessage = "";
    nextlevelQuizInfoId = 0;
    nextlevelQuizInfoTitle = "";
    quizInfoID = 0;

    // Reset timers or controllers if needed
    countDownController.restart();
    if (pageController.initialPage != 0) {
      pageController.jumpToPage(0);
    }

    update();
  }

  @override
  void onClose() {
    debugPrint("called onclose qc");
    super.onClose();
  }
}
