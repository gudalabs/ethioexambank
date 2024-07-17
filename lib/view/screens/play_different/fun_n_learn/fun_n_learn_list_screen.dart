import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_description.dart';
import 'package:quiz_lab/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/category-card/categories_card.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

import '../../../../core/helper/ads/admob_helper.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/url_container.dart';
import '../../../components/no_data.dart';

class FunNlearnListScreen extends StatefulWidget {
  final String title;
  const FunNlearnListScreen({super.key, required this.title});

  @override
  State<FunNlearnListScreen> createState() => _FunNlearnListScreenState();
}

class _FunNlearnListScreenState extends State<FunNlearnListScreen> {
  String title = "";
  String subCategoryId = "";
  String mainCategoryId = "";
  AdmobHelper admobHelper = AdmobHelper();
  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));
    Get.put(FunNLearnListController(
      funNLearnRepo: Get.find(),
    ));
    FunNLearnListController controller = Get.put(FunNLearnListController(funNLearnRepo: Get.find()));

    title = Get.arguments[0] as String;
    subCategoryId = Get.arguments[1];
    mainCategoryId = Get.arguments[2];
    // admobHelper.createInterstitialAd();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getFunAndLearnDescriprion(subCategoryId, mainCategoryId);
    });
  }

  bool iscardexpand = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunNLearnListController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: title.tr,
        ),
        body: controller.loader
            ? const CustomLoader()
            : controller.fun_N_Learn_descriptionList.isEmpty
                ? NoDataWidget(
                    messages: MyStrings.noFunAndLearnFound.tr,
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
                            shrinkWrap: true,
                            itemCount: controller.fun_N_Learn_descriptionList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CategoriesCard(
                                onTap: () {
                                  admobHelper.showInterstitialAd();
                                  if (controller.fun_N_Learn_descriptionList[index].questionsCount.toString() == "0") {
                                    CustomSnackBar.error(errorList: [MyStrings.noQuestionFoundMsg.tr]);
                                  } else {
                                    Get.toNamed(RouteHelper.funNlearnDescriptionScreen, arguments: [controller.fun_N_Learn_descriptionList[index].title.toString(), controller.fun_N_Learn_descriptionList[index].id.toString(), controller.fun_N_Learn_descriptionList[index].description.toString()]);
                                    // controller.changeExpandIndex(index);
                                  }
                                },
                                showLevel: false,
                                index: index,
                                imageMainPath: controller.fun_N_Learn_descriptionList[index].image.toString(),
                                image: UrlContainer.subCategoriesImage + controller.fun_N_Learn_descriptionList[index].image.toString(),
                                title: controller.fun_N_Learn_descriptionList[index].title.toString(),
                                questions: controller.fun_N_Learn_descriptionList[index].questionsCount.toString(),
                                expansionVisible: false,
                                fromViewAll: false,
                                isExpand: index == controller.expandIndex,
                                // levels: controller.itemCount.toString(),
                              );
                            }),
                      ],
                    ),
                  ),
      ),
    );
  }
}
