import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quiz_lab/core/utils/style.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';

class OTPFieldWidget extends StatelessWidget {
  final Color textcolor, activeColor, inActiveColor;
  final bool fromExam;
  final int length;
  final TextEditingController? tController; // Changed to optional

  const OTPFieldWidget({
    Key? key,
    this.tController, // Made it optional
    required this.onChanged,
    this.textcolor = MyColor.textColor,
    this.activeColor = MyColor.screenBgColor,
    this.inActiveColor = MyColor.cardBorderColors,
    this.fromExam = false,
    this.length = 6,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10),
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: regularDefault.copyWith(color: MyColor.getTextColor()),
        length: length,
        textStyle: regularExtraLarge.copyWith(color: MyColor.textColor),
        obscureText: false,
        autovalidateMode: AutovalidateMode.always,
        controller: tController,
        obscuringCharacter: '*',
        blinkWhenObscuring: false,
        animationType: AnimationType.fade,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        pinTheme: PinTheme(
            fieldOuterPadding: const EdgeInsets.all(Dimensions.space1),
            shape: PinCodeFieldShape.box,
            borderWidth: Dimensions.space1,
            borderRadius: BorderRadius.circular(Dimensions.space8),
            fieldHeight: Dimensions.space45 - 8,
            fieldWidth: Dimensions.space45 -8,
            inactiveColor: MyColor.cardBorderColors,
            inactiveFillColor: MyColor.colorWhite,
            activeFillColor: activeColor,
            activeColor: MyColor.getPrimaryColor(),
            selectedFillColor: MyColor.getScreenBgColor(),
            selectedColor: MyColor.getPrimaryColor()),
        cursorColor: MyColor.colorBlack,
        animationDuration: const Duration(milliseconds: 100),
        enableActiveFill: true,
        keyboardType: fromExam ? TextInputType.name : TextInputType.number,
        beforeTextPaste: (text) {
          return true;
        },
        onChanged: (value) => onChanged!(value),
      ),
    );
  }
}
