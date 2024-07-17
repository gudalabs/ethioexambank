import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/auth/login_controller.dart';
import 'package:quiz_lab/data/repo/auth/login_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:quiz_lab/view/components/divider/custom_divider.dart';
import 'package:quiz_lab/view/components/social_login/social_login_section.dart';
import 'package:quiz_lab/view/components/text/custom_underline_text.dart';
import 'package:quiz_lab/view/components/text/default_text.dart';
import 'package:get/get.dart';
import '../../../../components/text-form-field/custom_text_field.dart';

class LoginBodySection extends StatefulWidget {
  const LoginBodySection({super.key});

  @override
  State<LoginBodySection> createState() => _LoginBodySectionState();
}

class _LoginBodySectionState extends State<LoginBodySection> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25, vertical: Dimensions.space7),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.welcomeBack.tr,
                    style: semiBoldMediumLarge.copyWith(
                      fontSize: Dimensions.space25,
                    ),
                  ),
                  const SizedBox(height: Dimensions.space6),
                  Text(
                    MyStrings.pleaseEnterDetails.tr,
                    style: regularLarge.copyWith(
                      color: MyColor.authScreenTextColor,
                      fontSize: Dimensions.space15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            SocialLoginSection(
              loginController: controller,
            ),
            const CustomDivider(space: Dimensions.space10),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: controller.emailController,
                    hasIcon: true,
                    hastextcolor: true,
                    prefixicon: MyImages.personSVG,
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.username.tr,
                    onChanged: (value) {},
                    textInputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return MyStrings.fieldErrorMsg.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.space20),
                  CustomTextField(
                    controller: controller.passwordController,
                    hasIcon: true,
                    prefixicon: MyImages.lockSVG,
                    hastextcolor: true,
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.password.tr,
                    onChanged: (value) {},
                    isShowSuffixIcon: true,
                    isPassword: true,
                    textInputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return MyStrings.fieldErrorMsg.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.space12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: Dimensions.space25,
                            height: Dimensions.space25,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.space5)),
                              activeColor: MyColor.primaryColor,
                              checkColor: MyColor.colorWhite,
                              value: controller.remember,
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: Dimensions.space1, color: controller.remember ? MyColor.getTextFieldEnableBorder() : MyColor.getTextFieldDisableBorder()),
                              ),
                              onChanged: (value) {
                                controller.changeRememberMe();
                              }),
                          ),
                          const SizedBox(width: Dimensions.space8),
                          DefaultText(
                            text: MyStrings.rememberMe.tr,
                            textColor: MyColor.getAuthTextColor(),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.forgetpasswordScreen);
                        },
                        child: DefaultText(
                          text: MyStrings.forgotPassword.tr,
                          textColor: MyColor.getAuthTextColor(),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: Dimensions.space25),
                  controller.isSubmitLoading ?
                  const RoundedLoadingBtn() :
                  RoundedButton(
                    text: MyStrings.signIn.tr,
                    press: () {

                      if (formKey.currentState!.validate()) {
                        controller.loginUser();
                      }
                    }),
                  const SizedBox(height: Dimensions.space10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        MyStrings.doNotHaveAccount.tr,
                        overflow: TextOverflow.ellipsis,
                        style: mediumOverSmall.copyWith(
                          fontSize: Dimensions.space14,
                          color: MyColor.getAuthTextColor(),
                        )
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(RouteHelper.signupScreen);
                        },
                        child: CustomUndelineText(text: MyStrings.signUp.tr),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
