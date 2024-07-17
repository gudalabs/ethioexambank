import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';

import '../../../../../data/controller/my_language_controller/my_language_controller.dart';
import '../../../../../data/repo/auth/general_setting_repo.dart';

class LanguageBottomSheetScreen extends StatefulWidget {
  const LanguageBottomSheetScreen({super.key});

  @override
  State<LanguageBottomSheetScreen> createState() => _LanguageBottomSheetScreenState();
}

class _LanguageBottomSheetScreenState extends State<LanguageBottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyLanguageController>(
        init: MyLanguageController(repo: Get.put(GeneralSettingRepo(apiClient: Get.find())), localizationController: Get.find()),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.controller!.loadAppLanguage();
          });
        },
        builder: (myLanguageController) {
          return Center(
              child: SizedBox(
            width: double.infinity,
            height: 300,
            child: Column(
              children: [
                const SizedBox(height: Dimensions.space10),
                const BottomSheetBar(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    MyStrings.selectALanguage.tr,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if (myLanguageController.isChangeLangLoading == true) ...[
                  const Expanded(
                    child: CustomLoader(
                      isPagination: true,
                    ),
                  )
                ] else ...[
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: myLanguageController.appLanguageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final language = myLanguageController.appLanguageList[index];
                        final selectedValue = myLanguageController.appLanguageList[myLanguageController.selectedIndex];

                        return RadioListTile(
                          activeColor: MyColor.primaryColor,
                          title: Text(language.languageName),
                          value: language,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            // var langValue = value as MyLanguageModel;

                            myLanguageController.changeLanguage(index);
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ));
        });
  }
}
