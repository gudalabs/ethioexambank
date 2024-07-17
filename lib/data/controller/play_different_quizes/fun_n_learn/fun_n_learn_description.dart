// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/data/model/play_different_quizes/fun_n_learn/fun_n_learn_description_model.dart';
import 'package:quiz_lab/data/model/sub_categories/sub_categories_model.dart';
import 'package:quiz_lab/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class FunNLearnListController extends GetxController {
  FunNLearnRepo funNLearnRepo;

  FunNLearnListController({required this.funNLearnRepo});

  String id = "";
  List<FunList> fun_N_Learn_descriptionList = [];
  List<Category> quizIinfosList = [];

  String title = "";
  String subCategoryId = "";
  String description = "";

  bool loader = true;

  bool isActive = false;
  bool viewMore = false;
  bool showExpandedSection = false;

  void getFunAndLearnDescriprion(String subcategoryId, String mainCategoryId) async {
    loader = true;
    update();

    ResponseModel model = await funNLearnRepo.getFunAndLearnDescription(subcategoryId, mainCategoryId);

    if (model.statusCode == 200) {
      fun_N_Learn_descriptionList.clear();

      FunNLearnDescriptionModel funandLearnDescription = FunNLearnDescriptionModel.fromJson(jsonDecode(model.responseJson));

      if (funandLearnDescription.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {


        List<FunList>? subcategorylist = funandLearnDescription.data?.funList;

        if (subcategorylist != null && subcategorylist.isNotEmpty) {
          fun_N_Learn_descriptionList.addAll(subcategorylist);
        }
      } else {
        CustomSnackBar.error(errorList: [...funandLearnDescription.message!.error!]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    debugPrint('---------------------${model.statusCode}');

    loader = false;
    update();
  }

  int expandIndex = -1;
  void changeExpandIndex(int index) {
    if (expandIndex == index) {
      expandIndex = -1;
      update();
      return;
    }
    expandIndex = index;
    update();
  }
}
