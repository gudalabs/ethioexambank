import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import '../../../core/utils/style.dart';

class CustomUndelineText extends StatelessWidget {
  final String text;
  const CustomUndelineText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: MyColor.primaryColor,
      ))),
      child: Text(
        text,
        style: regularMediumLarge.copyWith(
          color: MyColor.primaryColor,
        ),
      ),
    );
  }
}
