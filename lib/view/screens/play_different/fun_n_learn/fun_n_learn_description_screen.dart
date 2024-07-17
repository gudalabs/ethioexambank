import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_description.dart';
import 'package:quiz_lab/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';

class FunNLearnDescription extends StatefulWidget {
  const FunNLearnDescription({super.key});

  @override
  State<FunNLearnDescription> createState() => _FunNLearnDescriptionState();
}

class _FunNLearnDescriptionState extends State<FunNLearnDescription> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));

    FunNLearnListController controller = Get.put(FunNLearnListController(
      funNLearnRepo: Get.find(),
    ));

    controller.title = Get.arguments[0] as String;
    controller.subCategoryId = Get.arguments[1];
    controller.description = Get.arguments[2];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunNLearnListController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(title: controller.title.tr),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(Dimensions.space10),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.space15),
                  child: Column(
                    children: [
                      Text(controller.description),
                      const SizedBox(height: Dimensions.space20),
                      RoundedButton(
                          text: MyStrings.letsPlay.tr,
                          press: () {
                            Get.offAndToNamed(RouteHelper.funNlearnQuizScreen, arguments: [controller.title, controller.subCategoryId]);
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
