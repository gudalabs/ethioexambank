import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/auth/forget_password/forget_password_controller.dart';
import 'package:quiz_lab/data/repo/auth/login_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:quiz_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:get/get.dart';

class ForgetPasswordBodySection extends StatefulWidget {
  const ForgetPasswordBodySection({super.key});

  @override
  State<ForgetPasswordBodySection> createState() => _ForgetPasswordBodySectionState();
}

class _ForgetPasswordBodySectionState extends State<ForgetPasswordBodySection> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (auth) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.space40,
          vertical: Dimensions.space30,
        ),
        child: Column(
          children: [
            Text(
              MyStrings.enterEmailAndPassword.tr,
              textAlign: TextAlign.center,
              style: regularLarge.copyWith(color: MyColor.authScreenTextColor),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.space20),
                  CustomTextField(
                      controller: auth.emailOrUsernameController,
                      hastextcolor: true,
                      hasIcon: true,
                      prefixicon: MyImages.mailSVG,
                      animatedLabel: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.email.tr,
                      onChanged: (value) {},
                      textInputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (auth.emailOrUsernameController.text.isEmpty) {
                          return MyStrings.enterEmailOrUserName.tr;
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(height: Dimensions.space40),
                  auth.submitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                          text: MyStrings.continues.tr,
                          press: () {
                            if (formKey.currentState!.validate()) {
                              auth.submitForgetPassCode();
                            }
                          }),
                  const SizedBox(height: Dimensions.space10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
