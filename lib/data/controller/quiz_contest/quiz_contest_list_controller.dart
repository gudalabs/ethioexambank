import 'dart:convert';
import 'package:quiz_lab/data/model/quiz_contest/quiz_contest_list_model.dart';
import 'package:quiz_lab/data/repo/quiz_contest/quiz_contest_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';


class QuizQuestionsListController extends GetxController {
  QuizContestRepo quizContestRepo;

  QuizQuestionsListController({
    required this.quizContestRepo,
  });

  bool loading = true;

  List<Contest> examcategoryList = [];

  void getQuizcontestList() async {
    loading = true;

    update();

    ResponseModel model = await quizContestRepo.quizListData();

    if (model.statusCode == 200) {
      examcategoryList.clear();

      QuizContestListModel examZoneModel = QuizContestListModel.fromJson(jsonDecode(model.responseJson));

      if (examZoneModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Contest>? examList = examZoneModel.data?.contests;

        if (examList != null && examList.isNotEmpty) {
          examcategoryList.addAll(examList);
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
}
