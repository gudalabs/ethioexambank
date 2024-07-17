import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/core/utils/util.dart';
import 'package:quiz_lab/view/components/image_widget/my_image_widget.dart';

class CustomTopCategoryCard extends StatelessWidget {
  final String title, questionsQuantaty, image;
  final int? index;

  const CustomTopCategoryCard({
    super.key,
    required this.title,
    required this.questionsQuantaty,
    required this.image,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.space5),
      child: Container(
        padding: const EdgeInsets.all(Dimensions.space7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.space8),
          boxShadow: MyUtils.getCardShadow(),
          border: Border.all(color: MyColor.borderColor.withOpacity(.3),width: .5)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyImageWidget(
              imageUrl: image,
              width: Dimensions.space50,
              height: Dimensions.space50,
            ),
            const SizedBox(height: Dimensions.space10 ),
            Text(
              title.toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: mediumDefault.copyWith(fontWeight: FontWeight.normal, color: MyColor.primaryTextColor),
            )
          ],
        ),
      ),
    );
  }
}
