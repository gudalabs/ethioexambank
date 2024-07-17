import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/data/model/play_different_quizes/fun_n_learn/fun_n_learn_category_model.dart';
import 'package:quiz_lab/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class FunNLearnCategoriesController extends GetxController {
  FunNLearnRepo funNLearnRepo;

  FunNLearnCategoriesController({required this.funNLearnRepo});

  List<Category> allCategoriesList = [];

  bool loader = true;

  bool isActive = false;
  bool viewMore = false;

  void getFunNLearndata() async {
    loader = true;
    update();

    ResponseModel model = await funNLearnRepo.getFunAndLearnCategories();

    if (model.statusCode == 200) {
      allCategoriesList.clear();

      FunNLearnCategoryModel allcategories = FunNLearnCategoryModel.fromJson(jsonDecode(model.responseJson));

      if (allcategories.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Category>? categories = allcategories.data?.categories;

        if (categories != null && categories.isNotEmpty) {
          allCategoriesList.addAll(categories);
        }
      } else {
        CustomSnackBar.error(errorList: [...allcategories.message!.error!]);
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
}
