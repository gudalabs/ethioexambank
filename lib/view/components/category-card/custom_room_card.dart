import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCreateRoomCoinCard extends StatelessWidget {
  final String title, image;
  final bool selected;
  const CustomCreateRoomCoinCard({
    super.key,
    required this.title,
    required this.image,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.space5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
        width: Dimensions.space103,
        decoration: BoxDecoration(
          color:  selected?MyColor.primaryColor.withOpacity(.1) : MyColor.transparentColor,
          border: Border.all(width:.8,color: selected?MyColor.primaryColor : MyColor.cardBorderColor),
          borderRadius: BorderRadius.circular(Dimensions.space8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image,height: 18,width: 18),
            const SizedBox(
              height: Dimensions.space8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space1, horizontal: Dimensions.space5),
              child: Text(
                title.toString(),
                textAlign: TextAlign.center,
                style: semiBoldMediumLarge.copyWith(color: MyColor.colorBlack),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
