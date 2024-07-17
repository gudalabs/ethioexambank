import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/data/model/all_cartegories/all_categories_model.dart';
import 'package:quiz_lab/data/repo/allcategories/all_categories_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class AllCategoriesController extends GetxController {
  AllCategoriesRepo allCategoriesRepo;

  AllCategoriesController({required this.allCategoriesRepo});

  List<Category> allCategoriesList = [];

  bool loader = true;

  bool isActive = false;
  bool viewMore = false;

  void getdata() async {
    loader = true;
    update();

    ResponseModel model = await allCategoriesRepo.getData();

    if (model.statusCode == 200) {
      allCategoriesList.clear();

      AllCategoriesModel allcategories = AllCategoriesModel.fromJson(jsonDecode(model.responseJson));

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
