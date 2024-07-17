import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import '../../../core/utils/style.dart';

class CustomTextWithUndeline extends StatelessWidget {
  final String text;
  final Color textColor;
  const CustomTextWithUndeline({super.key, required this.text,  this.textColor=MyColor.colorBlack});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color:textColor,
      ))),
      child: Text(
        text,
        style: regularLarge.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
