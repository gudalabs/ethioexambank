import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/auth/verification/email_verification_model.dart';
import 'package:quiz_lab/data/repo/auth/login_repo.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class VerifyPasswordController extends GetxController {
  LoginRepo loginRepo;
  VerifyPasswordController({required this.loginRepo});

  String email = '';
  String password = '';
  bool isLoading = false;
  bool remember = false;
  bool hasError = false;

  List<String> errors = [];
  String currentText = "";
  String confirmPassword = '';
  DateTime? lastResendTime;
  Timer? resendTimer;

  RxBool isResendLoading = false.obs;
  RxBool isResendButtonLoading = false.obs;

  int resendDelaySeconds = 30; // Set the resend delay time in seconds
  RxInt resendCountdown = 0.obs; // Countdown timer in seconds

  void startResendCountdown() {
    isResendLoading.value = true;
    resendCountdown.value = resendDelaySeconds;
    update();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        isResendLoading.value = false;
        timer.cancel();
      }
      update();
    });
  }

  void resendForgetPassCode() async {
    if (!isResendLoading.value) {
      isResendButtonLoading.value = true;
      // Trigger the resend code function
      String value = email;
      String type = 'email';
      await loginRepo.forgetPassword(type, value);
  isResendButtonLoading.value = false;
      // Start the resend countdown
      startResendCountdown();
    }
  }

  bool verifyLoading = false;

  void verifyForgetPasswordCode(String value) async {
    if (value.isNotEmpty) {
      verifyLoading = true;
      update();

      EmailVerificationModel model = await loginRepo.verifyForgetPassCode(value);

      if (model.code == 200) {
        verifyLoading = false;
        Get.offAndToNamed(RouteHelper.resetPassword, arguments: [email, value]);
        debugPrint("this is email $email");
      } else {
        verifyLoading = false;
        update();
        List<String> errorList = [MyStrings.verificationFailed.tr];
        CustomSnackBar.error(errorList: model.message?.error ?? errorList);
      }
    }
  }

  String getFormatedMail() {
    try {
      List<String> tempList = email.split('@');
      int maskLength = tempList[0].length;
      String maskValue = tempList[0][0].padRight(maskLength, '*');
      String value = '$maskValue@${tempList[1]}';
      return value;
    } catch (e) {
      return email;
    }
  }
}
