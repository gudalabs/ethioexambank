import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/exam_zone/exam_zone_controller.dart';
import 'package:quiz_lab/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:quiz_lab/view/components/text/default_text.dart';
import 'package:get/get.dart';

import '../../../../data/model/dashboard/dashboard_model.dart';
import '../../../../data/model/dashboard/exam.dart';
import '../../../../data/model/exam_zone/exam_zone_question_list_model.dart';
import '../../../components/buttons/rounded_loading_button.dart';

class EnterRoomBottomSheetWidget extends StatefulWidget {
  final Exams? quizInfo;
  const EnterRoomBottomSheetWidget({
    super.key,
    this.quizInfo,
  });

  @override
  State<EnterRoomBottomSheetWidget> createState() => _EnterRoomBottomSheetWidgetState();
}

class _EnterRoomBottomSheetWidgetState extends State<EnterRoomBottomSheetWidget> {
  bool viewAll = false;
  Exams? exmData;
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExamZoneRepo(apiClient: Get.find()));

    Get.put(ExamZoneController(
      examZoneRepo: Get.find(),
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamZoneController>(
      initState: (c) {
        exmData = widget.quizInfo;
      },
      builder: (controller) {
        return Container(
          padding: const EdgeInsetsDirectional.only(top: Dimensions.space10, start: Dimensions.space10, end: Dimensions.space10),
          child: Column(
            children: [
              const BottomSheetBar(),
              const SizedBox(height: Dimensions.space20),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  child: Column(
                    children: [
                      Text(
                        "${exmData?.title}",
                        style: semiBoldExtraLarge,
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Text(MyStrings.examKey.tr,
                          style: regularLarge.copyWith(
                            color: MyColor.textColor,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
                        child: OTPFieldWidget(
                          onChanged: (value) {
                            controller.enterExamKey = value;
                          },
                          length: 6,
                          fromExam: true,
                          inActiveColor: MyColor.colorWhite,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space10),
                        width: double.infinity,
                        decoration: BoxDecoration(color: MyColor.cardColor, border: Border.all(color: MyColor.cardBorderColor), borderRadius: BorderRadius.circular(Dimensions.space8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MyStrings.examRules.tr,
                              textAlign: TextAlign.center,
                              style: semiBoldMediumLarge,
                            ),
                            const SizedBox(
                              height: Dimensions.space10,
                            ),
                            if (widget.quizInfo != null)
                              IntrinsicHeight(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: Dimensions.space90 * 2.5,
                                    // maxHeight: 0,
                                  ),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Container(
                                      padding: const EdgeInsets.all(Dimensions.space8),
                                      width: double.infinity,
                                      color: Colors.transparent,
                                      child: widget.quizInfo!.examRule!.isEmpty
                                          ? Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: List.generate(
                                                MyStrings().rules.length,
                                                (index) {
                                                  return Container(
                                                    margin: const EdgeInsets.all(Dimensions.space5),
                                                    color: Colors.transparent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('\u2022', textAlign:TextAlign.start,style: regularLarge.copyWith(overflow: TextOverflow.visible, color: MyColor.redCancelTextColor, fontSize: 20)),
                                                        const SizedBox(
                                                          width: Dimensions.space10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            MyStrings().rules[index],
                                                            style: regularLarge.copyWith(overflow: TextOverflow.visible, color: MyColor.textColor),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: List.generate(
                                                viewAll == true
                                                    ? exmData!.examRule!.length
                                                    : exmData!.examRule!.length <= 3
                                                        ? exmData!.examRule!.length
                                                        : 3,
                                                (index) {
                                                  List<String> examRulesItem = [];
                                                  if (widget.quizInfo != null) {
                                                    examRulesItem = widget.quizInfo!.examRule!;
                                                  }

                                                  return Container(
                                                    margin: const EdgeInsetsDirectional.only(bottom: Dimensions.space5),
                                                    color: Colors.transparent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text('\u2022', style: regularLarge.copyWith(overflow: TextOverflow.visible, color: MyColor.redCancelTextColor, fontSize: 20)),
                                                        const SizedBox(
                                                          width: Dimensions.space10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            examRulesItem[index].toString(),
                                                            style: regularLarge.copyWith(overflow: TextOverflow.visible, color: MyColor.textColor),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            if (exmData!.examRule!.length >= 3)
                              Column(
                                children: [
                                  const SizedBox(
                                    height: Dimensions.space10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      debugPrint(viewAll.toString());
                                      viewAll = !viewAll;
                                      controller.update();
                                    },
                                    child: Text(
                                      viewAll == false ? "${MyStrings.viewAllRules.tr} ↑ " : "${MyStrings.viewLessRules.tr} ↓ ",
                                      style: regularLarge.copyWith(color: MyColor.textColor, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimensions.space25,
                              height: Dimensions.space25,
                              child: Checkbox(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.space5)),
                                  activeColor: MyColor.primaryColor,
                                  checkColor: MyColor.colorWhite,
                                  value: controller.agreeExamRules,
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(width: Dimensions.space1, color: controller.agreeExamRules ? MyColor.getTextFieldEnableBorder() : MyColor.getTextFieldDisableBorder()),
                                  ),
                                  onChanged: (value) {
                                    controller.changeExamRules(value!);
                                  }),
                            ),
                            const SizedBox(width: Dimensions.space8),
                            DefaultText(
                              text: MyStrings.iAgreewithrules.tr,
                              textColor: MyColor.getAuthTextColor(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.space30),
                      controller.submitLoading == true ?
                      const RoundedLoadingBtn()
                      : RoundedButton(
                          text: MyStrings.submit.tr,
                          press: () {
                            if (controller.enterExamKey == "") {
                              CustomSnackBar.error(errorList: [(MyStrings.examKeyMsg.tr)]);
                            } else {
                              if (controller.agreeExamRules == true) {
                                if (widget.quizInfo != null) {
                                  controller.enterExamZone(widget.quizInfo!.id.toString(), controller.enterExamKey);
                                }
                              } else {
                                CustomSnackBar.error(errorList: [(MyStrings.agreeExamRules.tr)]);
                              }
                            }
                          },
                          textSize: Dimensions.space20,
                          cornerRadius: Dimensions.space10,
                        ),
                      const SizedBox(
                        height: Dimensions.space20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
