import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/auth/forget_password/reset_password_controller.dart';
import 'package:quiz_lab/data/repo/auth/login_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:quiz_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:get/get.dart';

class ResetPasswordBodySection extends StatefulWidget {
  const ResetPasswordBodySection({super.key});

  @override
  State<ResetPasswordBodySection> createState() => _ResetPasswordBodySectionState();
}

class _ResetPasswordBodySectionState extends State<ResetPasswordBodySection> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(ResetPasswordController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.email = Get.arguments[0];
      controller.code = Get.arguments[1];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.space40,
          vertical: Dimensions.space20,
        ),
        child: Column(
          children: [
            Text(
              MyStrings.resetpassword.tr,
              style: regularDefault.copyWith(fontSize: Dimensions.space20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: Dimensions.space8),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.space20),
                  CustomTextField(
                    controller: controller.passController,
                    focusNode: controller.passwordFocusNode,
                    nextFocus: controller.confirmPasswordFocusNode,
                    hastextcolor: true,
                    hasIcon: true,
                    prefixicon: MyImages.lockSVG,
                    animatedLabel: true,
                    needOutlineBorder: true,
                    isShowSuffixIcon: true,
                    isPassword: true,
                    labelText: MyStrings.newPassword.tr,
                    onChanged: (value) {
                      if (controller.checkPasswordStrength) {
                        controller.updateValidationList(value);
                      }
                      return;
                    },
                    textInputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      return controller.validatePassword(value);
                    },
                  ),
                  const SizedBox(height: Dimensions.space25),
                  CustomTextField(
                    hastextcolor: true,
                    hasIcon: true,
                    controller: controller.confirmPassController,
                    prefixicon: MyImages.lockSVG,
                    animatedLabel: true,
                    needOutlineBorder: true,
                    isShowSuffixIcon: true,
                    isPassword: true,
                    labelText: MyStrings.confirmPassword.tr,
                    onChanged: (value) {},
                    textInputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      if (controller.passController.text.toLowerCase() != controller.confirmPassController.text.toLowerCase()) {
                        return MyStrings.kMatchPassError.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.space40),
                  controller.submitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                          text: MyStrings.continues.tr,
                          press: () {
                            if (formKey.currentState!.validate()) {
                              controller.resetPassword();
                            }
                            // Get.toNamed(RouteHelper.loginScreen);
                          },
                          textSize: Dimensions.space17),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
