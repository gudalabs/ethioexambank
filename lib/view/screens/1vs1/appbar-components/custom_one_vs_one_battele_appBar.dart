import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/style.dart';

class CustomOneVSOneAppBar extends StatelessWidget {
  final double appbarSize;
  final bool isGroupBattle;
  const CustomOneVSOneAppBar({super.key, required this.appbarSize, this.isGroupBattle = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: appbarSize < kToolbarHeight ? kToolbarHeight : appbarSize,
      child: AppBar(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.space15), bottomRight: Radius.circular(Dimensions.space15))),
        flexibleSpace: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(MyImages.appBarBGImage), fit: BoxFit.fitWidth),
          ),
        ),
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        title: Text(
          isGroupBattle ? MyStrings.groupBattle.tr : MyStrings.oneVSone.tr,
          style: semiBoldLarge.copyWith(fontSize: Dimensions.space17, color: MyColor.colorWhite),
        ),
      ),
    );
  }
}
