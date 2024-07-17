import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/data/model/auth/logout/logout_model.dart';

import 'package:quiz_lab/data/repo/auth/logout/logout_repo.dart';

import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class LogoutController extends GetxController {
  LogoutRepo logoutRepo;

  LogoutController({required this.logoutRepo});

  // Logout PART
  bool loaderStarted = false;

  void logout() async {
    loaderStarted = true;
    update();

    // getsavedData();

    ResponseModel logout = await logoutRepo.logout();

    if (logout.statusCode == 200) {
      LogoutModel plan = LogoutModel.fromJson(jsonDecode(logout.responseJson));
      if (plan.status.toString().toLowerCase() == MyStrings.ok.toLowerCase()) {
        Get.offAllNamed(RouteHelper.loginScreen);
        debugPrint("LoggedM OUT!");
        update();
      } else {
        CustomSnackBar.error(errorList: [...plan.message!.error!]);
      }
    } else {
      CustomSnackBar.error(errorList: [logout.message]);
    }

    loaderStarted = false;
    update();
  }

// Account Delete Part
  bool accountDeleteStarted = false;

  void deleteMyAccount() async {
    accountDeleteStarted = true;
    update();

    // getsavedData();

    ResponseModel logout = await logoutRepo.deleteMyAccount();

    if (logout.statusCode == 200) {
      LogoutModel delete = LogoutModel.fromJson(jsonDecode(logout.responseJson));
      if (delete.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        Get.offAllNamed(RouteHelper.loginScreen);
        CustomSnackBar.success(successList: [...delete.message!.success!]);
        debugPrint("Delete Account OUT!");
        update();
      } else {
        CustomSnackBar.error(errorList: [...delete.message!.error!]);
      }
    } else {
      CustomSnackBar.error(errorList: [logout.message]);
    }

    accountDeleteStarted = false;
    update();
  }
}
