import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/util.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';

class CustomCategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? children;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  const CustomCategoryAppBar({super.key, required this.title, this.children, this.systemUiOverlayStyle});

  @override
  Widget build(BuildContext context) {
    // Use the provided systemUiOverlayStyle or a default one
    final SystemUiOverlayStyle overlayStyle = systemUiOverlayStyle ?? MyUtils.fullAppSystemUIOverly;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: AppBar(
          systemOverlayStyle: overlayStyle,
          title: Text(
            title,
            style: semiBoldMediumLarge,
          ),
          backgroundColor: MyColor.colorWhite,
          iconTheme: const IconThemeData(color: MyColor.colorBlack),
          toolbarHeight: Dimensions.space70,
          elevation: .1,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(Dimensions.space25),
          )),
          actions: children,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        Dimensions.space56,
      );
}
