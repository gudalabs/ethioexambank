import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/repo/auth/login_repo.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class ForgetPasswordController extends GetxController {
  LoginRepo loginRepo;
  ForgetPasswordController({required this.loginRepo});

  bool submitLoading = false;
  TextEditingController emailOrUsernameController = TextEditingController();

  void submitForgetPassCode() async {
    String input = emailOrUsernameController.text;

    if (input.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.enterYourEmail.tr]);
      return;
    }

    submitLoading = true;
    update();

    String type = input.contains('@') ? 'email' : 'username';
    String responseEmail = await loginRepo.forgetPassword(type, input);

    if (responseEmail.isNotEmpty) {
      emailOrUsernameController.text = '';
      Get.toNamed(RouteHelper.verificationScreen, arguments: responseEmail);
      
    }
    debugPrint("this is email from forget password $responseEmail");
    submitLoading = false;
    update();
  }
}
