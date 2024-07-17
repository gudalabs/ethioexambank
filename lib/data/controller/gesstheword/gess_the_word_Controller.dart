// ignore_for_file: file_names

import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/guess_the_word/guess_question_model.dart';
import 'package:quiz_lab/data/model/guess_the_word/guess_subcategory_model.dart';
import 'package:quiz_lab/data/model/guess_the_word/guess_submit_response.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/repo/guess_the_word/guess_the_word_repo.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

import '../../model/guess_the_word/guess_category_model.dart';

class GuessTheWordController extends GetxController {
  GuessTheWordRepo guessTheWordRepo;
  GuessTheWordController({required this.guessTheWordRepo});

  PageController pageController = PageController(initialPage: 0);
  CountDownController countDownController = CountDownController();
  //
  String? imgPath = "";
  String? questionImgPath = "";
  String? subImgPath = "";
  int currentPage = 0;
  bool isLoading = false;
  int ansDuration = 30;
  String? quizInfoId;
  // result
  String appreciation = "";
  String totalQuestion = '';
  String correctAnswer = '';
  String wrongAnswer = '';
  String totalScore = '';

  void initialValue() async {
    imgPath = "";
    currentPage = 0;
    await getAllCategory();
  }

  // page controlling
  void nextPage() {
    if (pageController.initialPage < guessTheWordQuestionList.length) {
      clearAllData();
      pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    } else {}
  }

  // asn
  List<String> tempAns = [];

  void addAns(int questionIndex, String answer) {
    String modifiedString = answer.replaceAll('-1', '');
    guessTheWordQuestionList[questionIndex].setSelectedAnswer(modifiedString);
  }

//final submit Answers
  void submitGuessTheWordAnswers() async {
    isLoading = true;
    update();

    Map<String, dynamic> params = {};
    params['quizInfo_id'] = quizInfoId;
    for (int i = 0; i < guessTheWordQuestionList.length; i++) {
      String questionId = guessTheWordQuestionList[i].id.toString();
      String selectedOptionId = guessTheWordQuestionList[i].selectedAnswer.toString();
      params['question_id[]$questionId'] = questionId;
      params['option_$questionId'] = selectedOptionId.toString();
    }

    ResponseModel response = await guessTheWordRepo.submitAnswar(params);
    if (response.statusCode == 200) {
      GuessWordQuestionSubmitResponse model = GuessWordQuestionSubmitResponse.fromJson(jsonDecode(response.responseJson));
      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        debugPrint(model.message!.success!.first);
        appreciation = model.message!.success!.first;
        totalQuestion = model.data?.totalQuestion.toString() ?? '';
        correctAnswer = model.data?.correctAnswer.toString() ?? '';
        wrongAnswer = model.data?.wrongAnswer.toString() ?? '';
        totalScore = model.data?.totalScore.toString() ?? '';
        Get.offAndToNamed(
          RouteHelper.gessThewordResult,
        );

      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);
        Get.offAndToNamed(RouteHelper.guessTheWordCategory);
      }
    } else {
      Get.toNamed(RouteHelper.guessTheWordCategory);
      CustomSnackBar.error(errorList: [response.message]);
    }

    isLoading = false;
    update();
  }

  // selected index of value list
  int selectedIndex = 0;
  void clearIndex() {
    selectedIndex = 0;
    update();
  }

  void selectIndex(int index) {
    if (selectedIndex <= tempAns.length) {
      selectedIndex = index;
      update();
    }
  }

  void removeValue() {
    if (selectedIndex != tempAns.length) {
      tempAns.removeAt(selectedIndex);
      tempAns.insert(selectedIndex, "-1");
      selectedIndex = selectedIndex != 0 ? selectedIndex - 1 : selectedIndex;
      update();
    }
  }

  void replace(String val) {
    if (selectedIndex != tempAns.length) {
      tempAns.removeAt(selectedIndex);
      tempAns.insert(selectedIndex, val);
      selectedIndex = selectedIndex != tempAns.length ? selectedIndex + 1 : selectedIndex;

      update();
    }
  }

//
  List<GuessQuestion> guessTheWordQuestionList = [];
  List<GuessCategories> categoryList = [];
  List<GuessSubCategory> subCategories = [];

  Future<void> getAllCategory() async {
    isLoading = true;
    update();
    ResponseModel response = await guessTheWordRepo.getwordcategoryList();

    if (response.statusCode == 200) {
      GuessWordCategoryResponse model = GuessWordCategoryResponse.fromJson(jsonDecode(response.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GuessCategories>? tempcategorylist = model.data?.categories;
        if (tempcategorylist != null) {
          categoryList.clear();
          imgPath = model.data?.categoryImagePath;
          categoryList.addAll(tempcategorylist);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  Future<void> getAllSubCategories(String id) async {
    isLoading = true;
    update();
    ResponseModel response = await guessTheWordRepo.getwordSubCatagroiList(id);

    if (response.statusCode == 200) {
      GuessWordSubCategoryResponse model = GuessWordSubCategoryResponse.fromJson(jsonDecode(response.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GuessSubCategory>? tempList = model.data?.subcategories;
        if (tempList != null) {
          subCategories.clear();
          subCategories.addAll(tempList);
          subImgPath = model.data?.imgPath;
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  Future<void> getQuestion(String id) async {
    quizInfoId = '';
    isLoading = true;
    update();
    ResponseModel response = await guessTheWordRepo.getwordQuestionList(id);

    if (response.statusCode == 200) {
      GuessWordQuestionResponse model = GuessWordQuestionResponse.fromJson(jsonDecode(response.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GuessQuestion>? templist = model.data?.questions;
        if (templist != null) {
          guessTheWordQuestionList.clear();
          questionImgPath = model.data?.questionImagePath;
          ansDuration = int.parse(model.data?.perQuestionAnswerDuration.toString() ?? "30");
          quizInfoId = id;
          guessTheWordQuestionList.addAll(templist);
        }
        if (model.data!.questions!.isEmpty) {
          Get.back();
          CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.sorryNoQuizFound]);
        }
      } else {
        Get.back();
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      Get.back();
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  void clearAllData() {
    tempAns.clear();
    selectedIndex = 0;
    update();
  }
}
