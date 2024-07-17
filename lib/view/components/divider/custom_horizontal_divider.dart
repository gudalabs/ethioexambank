import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_color.dart';

class CustomHorizontalDivider extends StatelessWidget {
  final double height;
  final Color color;

  const CustomHorizontalDivider({
    Key? key,
    this.height = 0.1,
    this.color = MyColor.colorlighterGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: color,
    );
  }
}
