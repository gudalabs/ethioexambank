import 'package:flutter/widgets.dart';
import 'package:quiz_lab/data/model/play_different_quizes/fun_n_learn/fun_n_learn_category_model.dart';
import 'package:quiz_lab/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../model/play_different_quizes/fun_n_learn/fun_n_learn_sub_category_model.dart';

class FunNLearnSubCategoriesController extends GetxController {
  FunNLearnRepo funNLearnRepo;

FunNLearnSubCategoriesController({required this.funNLearnRepo});

  String id = "";
  List<Subcategory> subCategoriesList = [];
  List<Category> quizIinfosList = [];

  int itemCount = 0;

  bool loader = true;

  bool isActive = false;
  bool viewMore = false;
  bool showExpandedSection = false;

  void getdata(String subcategoryId) async {
    loader = true;
    update();

    ResponseModel model = await funNLearnRepo.getFunAndLearnSubCategories(subcategoryId);

    if (model.statusCode == 200) {
      subCategoriesList.clear();

      FunSubCategoryListModel subcategories = funSubCategoryListModelFromJson(model.responseJson);

      if (subcategories.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        // id =subcategories.data.subcategories.

        List<Subcategory>? subcategorylist = subcategories.data!.subcategories;

        if (subcategorylist.isNotEmpty) {
          subCategoriesList.addAll(subcategorylist);
        }

        itemCount = subcategorylist.length;
      } else {
        CustomSnackBar.error(errorList: [...subcategories.message.error!]);
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
