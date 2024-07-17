import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/model/battle/battle_question_list.dart';

class OptionButton extends StatelessWidget {
  final BattleQuestionOption option;
  final VoidCallback onTap;
  final bool isSelected;
  final String letter;

  const OptionButton({
    super.key,
    required this.option,
    required this.onTap,
    required this.isSelected,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(Dimensions.space8),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
        decoration: BoxDecoration(
          color: isSelected && option.isAnswer == "1"
              ? MyColor.rightAnswerbgColor
              : isSelected && option.isAnswer == "0"
                  ? MyColor.wrongAnsColor
                  : MyColor.transparentColor,
          borderRadius: BorderRadius.circular(Dimensions.space8),
          border: Border.all(
              color: isSelected && option.isAnswer == "1"
                  ? MyColor.rightAnswerbgColor
                  : isSelected && option.isAnswer == "0"
                      ? MyColor.wrongAnsColor
                      : MyColor.colorLightGrey),
        ),
        child: Row(
          children: [
            Text(
              "$letter)", // Assuming that the Option class has an 'optionLetter' property
              style: regularMediumLarge.copyWith(
                color: isSelected ? MyColor.colorWhite : MyColor.textColor,
              ),
            ),
            const SizedBox(width: Dimensions.space8),
            Expanded(
              child: Text(
                "${option.option} ",
                style: regularMediumLarge.copyWith(
                  overflow: TextOverflow.visible,
                  color: isSelected ? MyColor.colorWhite : MyColor.textColor,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.space10,
              child: SvgPicture.asset(
                isSelected && option.isAnswer == "1" ? MyImages().rightORWrong[0] : MyImages().rightORWrong[1],
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
