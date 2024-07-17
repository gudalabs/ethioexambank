import 'dart:convert';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/data/model/exam_zone/exam_zone_model.dart';

import 'package:quiz_lab/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../core/route/route.dart';
import '../../model/dashboard/exam.dart';
import '../../model/exam_zone/completed_exam_zone_model.dart';
import '../../model/exam_zone/exam_zone_question_list_model.dart';

class ExamZoneController extends GetxController with GetSingleTickerProviderStateMixin {
  ExamZoneRepo examZoneRepo;

  ExamZoneController({required this.examZoneRepo});

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;

  int currentQuestionIndex = 0;

  bool loading = true;
  bool loadingForCompletedList = true;

  String? quizInfoID;
  late int questionsIndex;
  List<Exams>? examcategoryList = [];
  List<CompletedExam> completedExamDataList = [];

  List<Option> optionsList = [];

  List selectedQuestionsId = [];
  List selectedAnswerId = [];

  late TabController tabController;
  int selectedIndex = 1;

  CountDownController countDownController = CountDownController();
  PageController pageController = PageController();
  int currentPage = 0;
  bool agreeExamRules = true;
  String enterExamKey = "";
  String quizInfoId = "";

  bool submitLoading = false;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);

    selectedIndex = tabController.index;
  }

  changeExamRules(bool value) {
    agreeExamRules = value;
    update();
  }

  changePage(int page) {
    currentPage = page;
    update();
  }

  selectTab() {
    selectedIndex = tabController.index;
    update();
  }

  //Todays Exam List
  void examZoneListData({bool fromLoad = false}) async {
    if (fromLoad == true) {
      loading = true;
    } else {
      loading = false;
    }

    update();

    ResponseModel model = await examZoneRepo.examZoneData();

    if (model.statusCode == 200) {
      examcategoryList!.clear();

      ExamZoneModel examZoneModel = ExamZoneModel.fromJson(jsonDecode(model.responseJson));

      if (examZoneModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Exams>? examList = examZoneModel.data!.exams;

        if (examList != null && examList.isNotEmpty) {
          examcategoryList!.addAll(examList);
        }
      } else {
        CustomSnackBar.error(errorList: [...examZoneModel.message!.error!]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    loading = false;
    update();
  }

  // Completed Exam LIst
  void completedExamList({bool fromLoad = false}) async {
    if (fromLoad == true) {
      loadingForCompletedList = true;
    } else {
      loadingForCompletedList = false;
    }

    update();

    ResponseModel model = await examZoneRepo.completedExamListData();

    if (model.statusCode == 200) {
      completedExamDataList.clear();

      CompletedExamListModel examZoneModel = completedExamListModelFromJson(model.responseJson);

      if (examZoneModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<CompletedExam>? examList = examZoneModel.data.exams;

        if (examList.isNotEmpty) {
          completedExamDataList.addAll(examList);
        }
      } else {
        CustomSnackBar.error(errorList: [examZoneModel.status]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    loadingForCompletedList = false;
    update();
  }

  //Enter to exam
  enterExamZone(String quizInfoId, enterExamKey) async {
    submitLoading = true;
    update();

    //GET EXAM DETAILS
    ResponseModel getQuestionsModel = await examZoneRepo.getExamDetails(quizInfoId.toString());

    if (getQuestionsModel.statusCode == 200) {
      ExamZoneQuestionsModel modelData = ExamZoneQuestionsModel.fromJson(jsonDecode(getQuestionsModel.responseJson));
      if (modelData.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        if (modelData.message!.success!.first.contains("already finished")) {
          Get.back();
          CustomSnackBar.success(successList: modelData.message!.success!);
        } else {
          Get.toNamed(RouteHelper.examZoneQuestionScreen, arguments: [quizInfoId, enterExamKey]);
        }
      } else {
        CustomSnackBar.error(errorList: modelData.message?.error ?? [MyStrings.somethingWentWrong.tr]);

        //need to cheak error msg
      }
    } else {
      CustomSnackBar.error(errorList: [getQuestionsModel.message]);
    }

    submitLoading = false;
    update();
  }
}
