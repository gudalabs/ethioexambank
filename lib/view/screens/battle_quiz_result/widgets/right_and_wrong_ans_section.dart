import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:flutter_svg/svg.dart';


class RightOrWrongAnsSection extends StatelessWidget {
  final String correctAns;
  final String wrongAns;
  final String totalQuestion;

  const RightOrWrongAnsSection({
    Key? key,
    required this.correctAns,
    required this.wrongAns,
    required this.totalQuestion,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyColor),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
          child: Row(
            children: [
              SvgPicture.asset(MyImages.greenTikSvg),
              const SizedBox(width: Dimensions.space6),
              Text(
                "$correctAns/$totalQuestion",
                style: regularDefault.copyWith(
                  color: MyColor.rightAnswerbgColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: Dimensions.space8, horizontal: Dimensions.space1),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyWrongColor),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
          child: Row(
            children: [
              SvgPicture.asset(MyImages.wrongSvg),
              const SizedBox(
                width: Dimensions.space6,
              ),
              Text(
                "$wrongAns/$totalQuestion",
                style: regularDefault.copyWith(color: MyColor.wrongAnsColor),
              ),
            ],
          ),
        )
      ],
    );
  }
}
