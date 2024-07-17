import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/auth/forget_password/verify_password_controller.dart';
import 'package:quiz_lab/data/repo/auth/login_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:quiz_lab/view/components/text/custom_underline_text.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/my_strings.dart';
import '../../../../../components/buttons/rounded_button.dart';

class VerificationBodySection extends StatefulWidget {
  const VerificationBodySection({super.key});

  @override
  State<VerificationBodySection> createState() => _VerificationBodySectionState();
}

class _VerificationBodySectionState extends State<VerificationBodySection> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(VerifyPasswordController(loginRepo: Get.find()));

    controller.email = Get.arguments;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyPasswordController>(
      builder: (controller) => controller.isLoading
          ? Center(child: CircularProgressIndicator(color: MyColor.getPrimaryColor()))
          : Column(
              children: [
                SizedBox(
                  height: Dimensions.space70,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        MyStrings.enterVerificationcode.tr,
                        style: regularDefault.copyWith(fontSize: Dimensions.space20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: Dimensions.space8,
                      ),
                      Text(
                        '${MyStrings.wehaveSentaCode.tr} ${controller.email.toString()}',
                        style: regularLarge.copyWith(color: MyColor.authScreenTextColor),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimensions.space20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space40),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: regularDefault.copyWith(color: MyColor.getPrimaryColor()),
                          length: 6,
                          textStyle: regularExtraLarge.copyWith(color: MyColor.textColor),
                          obscureText: false,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderWidth: .5,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 45 - 7,
                              fieldWidth: 45 - 7,
                              inactiveColor: MyColor.getTextFieldDisableBorder(),
                              inactiveFillColor: MyColor.colorWhite,
                              activeFillColor: MyColor.getScreenBgColor(),
                              activeColor: MyColor.getPrimaryColor(),
                              selectedFillColor: MyColor.getScreenBgColor(),
                              selectedColor: MyColor.getPrimaryColor()),
                          cursorColor: MyColor.getTextColor(),
                          animationDuration: const Duration(milliseconds: 100),
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          beforeTextPaste: (text) {
                            return true;
                          },
                          onChanged: (value) {
                            setState(() {
                              controller.currentText = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: Dimensions.space25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space38),
                        child: controller.isLoading
                            ? const RoundedLoadingBtn()
                            : RoundedButton(
                                text: MyStrings.verifyNow.tr,
                                press: () {
                                  // Get.toNamed(RouteHelper.resetPassword);
                                  if (controller.currentText.length != 6) {
                                    controller.hasError = true;
                                  } else {
                                    controller.verifyForgetPasswordCode(controller.currentText);
                                  }
                                },
                                textSize: Dimensions.space17,
                              ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(Dimensions.space10),
                                child: Text(MyStrings.didNotReceiveCode.tr, style: regularLarge.copyWith(color: MyColor.getAuthTextColor(), fontWeight: FontWeight.w500)),
                              ),
                              controller.isResendButtonLoading.value == true
                                  ? const Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: SizedBox(
                                        height: 17,
                                        width: 17,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: MyColor.primaryColor,
                                        ),
                                      ),
                                    )
                                  : controller.isResendLoading.value
                                      ? const SizedBox.shrink()
                                      : TextButton(
                                          onPressed: () {
                                            controller.resendForgetPassCode();
                                          },
                                          child: CustomUndelineText(text: MyStrings.resendCode.tr)),
                            ],
                          )),
                      const SizedBox(height: Dimensions.space10),
                      Obx(() {
                        final resendCountdown = controller.resendCountdown.value;

                        return resendCountdown > 0 ? Text('${MyStrings.emailResendAvilableIn} ${resendCountdown.toString()} ${MyStrings.seconds}') : const SizedBox.shrink();
                      }),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
