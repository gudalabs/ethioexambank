import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/authorization/authorization_response_model.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/repo/auth/sms_email_verification_repo.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../../core/route/route.dart';

class EmailVerificationController extends GetxController {
  SmsEmailVerificationRepo repo;
  EmailVerificationController({required this.repo});

  bool needSmsVerification = false;
  bool isProfileCompleteEnable = false;

  String currentText = "";

  bool submitLoading = false;
  bool isLoading = true;
  bool resendLoading = false;

  loadData() async {
    isLoading = true;
    update();
    ResponseModel responseModel = await repo.sendAuthorizationRequest();

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'error') {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  Future<void> verifyEmail(String text) async {
    if (text.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg.tr]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(text);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
     debugPrint("this is========model");
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList: model.message?.success ?? [(MyStrings.emailVerificationSuccess.tr)]);


          debugPrint("this is==$needSmsVerification");
        

        if (needSmsVerification) {
          debugPrint("this is============");
          Get.offAndToNamed(RouteHelper.smsVerificationScreen, arguments: [isProfileCompleteEnable]);
          
        } else {
           debugPrint("this is_-------------------------------$isProfileCompleteEnable");
          Get.offAndToNamed(isProfileCompleteEnable ? RouteHelper.profileCompleteScreen : RouteHelper.bottomNavBarScreen);
           
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [(MyStrings.emailVerificationFailed.tr)]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading = false;
    update();
  }

  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: true);
    resendLoading = false;
    update();
  }
}
