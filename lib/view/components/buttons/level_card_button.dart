import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:flutter_svg/svg.dart';

class LevelCardButton extends StatelessWidget {
  final bool hasIcon, hasbgColor, hastextColor;
  final bool hasImage, lifelineUsed;
  final double? height, width;
  final String? text, image;
  final Color bgColor;
  final Color contentColor;
  final Color borderColor;
  final double hPadding,vPadding;
  final bool isQuestionCount;

  const LevelCardButton({Key? key, this.isQuestionCount = false,this.hPadding = Dimensions.space15,this.vPadding = Dimensions.space15, this.borderColor = MyColor.cardBorderColor , this.text, this.bgColor = MyColor.primaryColor, this.contentColor = MyColor.colorWhite, required this.hasIcon, this.image, this.height, this.width, required this.hasImage, this.lifelineUsed = false, this.hasbgColor = false, this.hastextColor = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isQuestionCount ?
      Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Dimensions.space5),
        border: Border.all(color: borderColor),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          hasIcon
              ? Opacity(
                  opacity: 20,
                  child: SvgPicture.asset(
                    image!,
                    colorFilter: const ColorFilter.mode(MyColor.prifileBG, BlendMode.srcIn),
                  ))
              : const SizedBox(),
          hasImage == false
              ? const SizedBox(
                  width: 3,
                )
              : const SizedBox(),
          hasImage == false
              ? Text(
                  text.toString(),
                  style: TextStyle(color: hastextColor ? MyColor.colorWhite : MyColor.colorBlack),
                )
              : lifelineUsed == true
                  ? SvgPicture.asset(
                      image!,
                      colorFilter: const ColorFilter.mode(MyColor.greyTextColor, BlendMode.srcIn),
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      image!,
                      fit: BoxFit.cover,
                    ),
        ],
      )),
    ) :
      Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: hasbgColor ? Dimensions.space1 : vPadding),
      decoration: BoxDecoration(
        color: hasbgColor
            ? bgColor
            : lifelineUsed == true
                ? MyColor.transparentColor
                : MyColor.transparentColor,
        borderRadius: BorderRadius.circular(Dimensions.space5),
        border: Border.all(color: borderColor),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          hasIcon
              ? Opacity(
                  opacity: 20,
                  child: SvgPicture.asset(
                    image!,
                    colorFilter: const ColorFilter.mode(MyColor.prifileBG, BlendMode.srcIn),
                  ))
              : const SizedBox(),
          hasImage == false
              ? const SizedBox(
                  width: 3,
                )
              : const SizedBox(),
          hasImage == false
              ? Text(
                  text.toString(),
                  style: TextStyle(color: hastextColor ? MyColor.colorWhite : MyColor.colorBlack),
                )
              : lifelineUsed == true
                  ? SvgPicture.asset(
                      image!,
                      colorFilter: const ColorFilter.mode(MyColor.greyTextColor, BlendMode.srcIn),
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      image!,
                      fit: BoxFit.cover,
                    ),
        ],
      )),
    );
  }
}
