import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/data/model/dashboard/dashboard_model.dart';
import 'package:quiz_lab/data/repo/dashboard/dashboard_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../core/route/route.dart';
import '../../model/auth/logout/logout_model.dart';
import '../../model/dashboard/exam.dart';
import '../../repo/auth/logout/logout_repo.dart';
import '../../repo/exam_zone/exam_zone_repo.dart';

class DashBoardController extends GetxController {
  DashBoardRepo dashRepo;
  ExamZoneRepo examZoneRepo;
  LogoutRepo logoutRepo;
  DashBoardController({required this.dashRepo, required this.examZoneRepo, required this.logoutRepo});

  String rank = "";
  String coins = "";
  String score = "";
  String? username = "";
  String? userImage = "";

  List<Category> categorylist = [];
  List<Contest> contestlist = [];
  List<Exams> examZonelist = [];
  List<QuizType> differentQuizlist = [];
  List<User> userdetails = [];

  //Home page section status
  String? generalQuizStatus = '0';
  String? contestStatus = '0';
  String? funNLearnStatus = '0';
  String? guessTheWordStatus = '0';
  String? examStatus = '0';
  String? dailyQuizStatus = '0';
  String? singleBattleStatus = '0';

  bool loader = true;

  bool isActive = false;

  void getHomePageData({bool fromRefresh = false}) async {
    if (userdetails.isEmpty || fromRefresh == true) {
      loader = true;
    } else {
      loader = false;
    }
    update();

    ResponseModel model = await dashRepo.getData();

    if (model.statusCode == 200) {
      userdetails.clear();
      categorylist.clear();
      contestlist.clear();
      differentQuizlist.clear();
      contestlist.clear();
      examZonelist.clear();

      if (model.responseJson == "") {
        logoutFromApp();
      } else {
        DashBoardModel dashBoard = DashBoardModel.fromJson(jsonDecode(model.responseJson));

        if (dashBoard.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
          userdetails.add(dashBoard.data!.user!);
          rank = dashBoard.data?.rank?.userRank ?? "";
          coins = dashBoard.data?.user?.coins ?? "";
          score = dashBoard.data?.user?.score ?? "";

          //Status check
          generalQuizStatus = dashBoard.data?.generalQuizStatus;
          contestStatus = dashBoard.data?.contestStatus;
          funNLearnStatus = dashBoard.data?.funNLearnStatus;
          guessTheWordStatus = dashBoard.data?.guessTheWordStatus;
          examStatus = dashBoard.data?.examStatus;
          dailyQuizStatus = dashBoard.data?.dailyQuizStatus;
          singleBattleStatus = dashBoard.data?.singleBattleStatus;

          //save User Data
          dashRepo.apiClient.setUserData(dashBoard.data!.user!.toJson());

          List<Category>? categories = dashBoard.data?.categories;

          if (categories != null && categories.isNotEmpty) {
            categorylist.addAll(categories);
          }

          List<Contest>? contest = dashBoard.data?.contest;

          if (contest != null && contest.isNotEmpty) {
            contestlist.addAll(contest);
          }

          List<Exams>? exams = dashBoard.data?.exams;

          if (exams != null && exams.isNotEmpty) {
            examZonelist.addAll(exams);
          }

          List<QuizType>? quizType = dashBoard.data?.quizType;

          if (quizType != null && quizType.isNotEmpty) {
            differentQuizlist.addAll(quizType);
          }

          username = dashBoard.data?.user!.username;
          userImage = dashBoard.data?.user!.avatar;
        } else {
          CustomSnackBar.error(errorList: [...dashBoard.message!.error!]);
        }
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    debugPrint('---------------------${model.statusCode}');

    loader = false;
    update();
  }

  changeactivestatus() {
    isActive = !isActive;
    update();
  }

  void logoutFromApp() async {
    ResponseModel logout = await logoutRepo.logout();

    if (logout.statusCode == 200) {
      if (logout.responseJson == '') {
        Get.offAllNamed(RouteHelper.loginScreen);
        return;
      } else {
        LogoutModel plan = LogoutModel.fromJson(jsonDecode(logout.responseJson));
        if (plan.status.toString().toLowerCase() == MyStrings.ok.toLowerCase()) {
          debugPrint("LoggedM OUT!");
          update();
          Get.offAllNamed(RouteHelper.loginScreen);
          return;
        } else {
          CustomSnackBar.error(errorList: [...plan.message!.error!]);
        }
      }
    } else {
      CustomSnackBar.error(errorList: [logout.message]);
    }

    update();
  }
}
