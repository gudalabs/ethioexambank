import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:quiz_lab/data/repo/guess_the_word/guess_the_word_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';

import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/screens/guess_the_word/category/widget/guess_category_card.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_color.dart';
import '../../../components/no_data.dart';

class GestheWordCategoryScreen extends StatefulWidget {
  const GestheWordCategoryScreen({super.key});

  @override
  State<GestheWordCategoryScreen> createState() => _GestheWordCategoryScreenState();
}

class _GestheWordCategoryScreenState extends State<GestheWordCategoryScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GuessTheWordRepo(apiClient: Get.find()));
    final controller = Get.put(GuessTheWordController(guessTheWordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.allCategory.tr),
      body: GetBuilder<GuessTheWordController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : controller.categoryList.isEmpty
                ? SingleChildScrollView(
                  child: NoDataWidget(
                      messages: MyStrings.noCategoryFound.tr,
                    ),
                )
                : RefreshIndicator(
                    color: MyColor.primaryColor,
                    onRefresh: () async {
                        controller.getAllCategory();
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: Dimensions.space20),
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        itemCount: controller.categoryList.length,
                        itemBuilder: (context, i) {
                          return GuessCategoryCard(
                            categories: controller.categoryList[i],
                            image: '${controller.imgPath}/${controller.categoryList[i].image}',
                          );
                        },
                      ),
                    ),
                  );
      }),
    );
  }
}
