import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_color.dart';

import 'my_strings.dart';

class MyUtils {
  //
  static String shuffleString(String input) {
    final List<String> characters = input.split('');
    final Random random = Random();

    for (int i = characters.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      String temp = characters[i];
      characters[i] = characters[j];
      characters[j] = temp;
    }

    return characters.join('');
  }

  static void vibrate() {
    HapticFeedback.heavyImpact();
    HapticFeedback.vibrate();
  }

  static splashScreen() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: MyColor.getPrimaryColor(), statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.getPrimaryColor(), systemNavigationBarIconBrightness: Brightness.light));
  }

  static allScreen() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: MyColor.getPrimaryColor(), statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.getScreenBgColor(), systemNavigationBarIconBrightness: Brightness.dark));
  }

  static SystemUiOverlayStyle fullAppSystemUIOverly = SystemUiOverlayStyle(statusBarColor: MyColor.getPrimaryColor(), statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.getPrimaryColor(), systemNavigationBarIconBrightness: Brightness.light);

  static dynamic getShadow() {
    return [
      BoxShadow(blurRadius: 15.0, offset: const Offset(0, 25), color: Colors.grey.shade500.withOpacity(0.6), spreadRadius: -35.0),
    ];
  }

  static dynamic getBottomSheetShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static dynamic getCardShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static getOperationTitle(String value) {
    String number = value;
    RegExp regExp = RegExp(r'^(\d+)(\w+)$');
    Match? match = regExp.firstMatch(number);
    if (match != null) {
      String? num = match.group(1) ?? '';
      String? unit = match.group(2) ?? '';
      String title = '${MyStrings.last.tr} $num ${unit.capitalizeFirst}';
      return title.tr;
    } else {
      return value.tr;
    }
  }

  String formatNumberWithLeadingZero(String number) {
    if (number.isEmpty) {
      return "00";
    } else {
      if (int.parse(number) < 10) {
        return '0$number';
      } else {
        return number.toString();
      }
    }
  }


  static Color getOptionReviewOptionBGColor({
    required String selectedOptionId,
    required String isAnswer,
    required bool isValidAnswer,
    required bool isWrong
  }) {

    print("selected optionId"+selectedOptionId.toString());
    print("isAnswer"+isAnswer.toString());
    print("is valid answer"+isValidAnswer.toString());
    print("is wrong : "+isWrong.toString());

    if (selectedOptionId.isEmpty) {
      return MyColor.colorWhite;
    }

    if (isAnswer == '1' && isValidAnswer) {
      return MyColor.rightAnswerbgColor;
    }

    if (isWrong) {
      return MyColor.wrongAnsColor;
    }

    if(isAnswer == '1'){
      return MyColor.rightAnswerbgColor;
    }

    return MyColor.colorWhite;
  }

  static Color getOptionBorderColor({
    required String selectedOptionId,
    required String isAnswer,
    required bool isValidAnswer,
    required bool isWrong
  }) {

    print(selectedOptionId.toString());
    print(isAnswer.toString());
    print(isValidAnswer.toString());
    print(isWrong.toString());

    if (selectedOptionId.isEmpty) {
      return  MyColor.borderColor.withOpacity(.5);
    }

    if (isAnswer == '1' && isValidAnswer) {
      return MyColor.transparentColor;
    }

    if (isWrong) {
      return MyColor.transparentColor;
    }

    return MyColor.borderColor.withOpacity(.5);
  }

  dynamic getBoxShadow({
    required String selectedOptionId,
    required String isAnswer,
    required bool isValidAnswer,
    required bool isWrong
  }) {

    if (selectedOptionId.isEmpty) {
      return  MyUtils.getCardShadow();
    }

    if (isValidAnswer) {
      return null;
    }

    if (isWrong) {
      return null;
    }

    return MyUtils.getCardShadow();
  }

}
