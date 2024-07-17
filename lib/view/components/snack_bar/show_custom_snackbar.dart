import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/helper/string_format_helper.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';

class CustomSnackBar {
  static error({required List<String> errorList, int duration = 5}) {
    String message = '';
    if (errorList.isEmpty) {
      message = MyStrings.somethingWentWrong.tr;
    } else {
      for (var element in errorList) {
        String tempMessage = element.tr;
        message = message.isEmpty ? tempMessage : "$message\n$tempMessage";
      }
    }
    message = Converter.removeQuotationAndSpecialCharacterFromString(message);
    Get.rawSnackbar(
      progressIndicatorBackgroundColor: MyColor.transparentColor,
      progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(Colors.transparent),
      messageText: Text(message, style: regularLarge.copyWith(color: MyColor.colorWhite)),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: MyColor.colorRed.withOpacity(0.8),
      borderRadius: 4,
      margin: const EdgeInsets.all(Dimensions.space8),
      padding: const EdgeInsets.all(Dimensions.space8),
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeIn,
      showProgressIndicator: true,
      leftBarIndicatorColor: MyColor.transparentColor,
      animationDuration: const Duration(seconds: 1),
      borderColor: MyColor.transparentColor,
      reverseAnimationCurve: Curves.easeOut,
      borderWidth: 2,
    );
  }

  static success({required List<String> successList, int duration = 5}) {
    String message = '';
    if (successList.isEmpty) {
      message = MyStrings.somethingWentWrong.tr;
    } else {
      for (var element in successList) {
        String tempMessage = element.tr;
        message = message.isEmpty ? tempMessage : "$message\n$tempMessage";
      }
    }
    message = Converter.removeQuotationAndSpecialCharacterFromString(message);
    Get.rawSnackbar(
         progressIndicatorBackgroundColor: MyColor.transparentColor,
      progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(MyColor.transparentColor),
      messageText: Text(message, style: regularLarge.copyWith(color: MyColor.colorWhite)),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: MyColor.colorGreen.withOpacity(0.8),
      borderRadius: 4,
      margin: const EdgeInsets.all(Dimensions.space8),
      padding: const EdgeInsets.all(Dimensions.space8),
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
      showProgressIndicator: true,
      leftBarIndicatorColor: MyColor.transparentColor,
      animationDuration: const Duration(seconds: 2),
      borderColor: MyColor.transparentColor,
      reverseAnimationCurve: Curves.easeOut,
      borderWidth: 2,
    );
  }
}
