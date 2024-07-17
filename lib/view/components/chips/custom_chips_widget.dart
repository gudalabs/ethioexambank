import 'package:flutter/material.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';

class CustomChipsWidget extends StatelessWidget {
  final Widget child;
  //Margins
  final double left;
  final double right;
  final double top;
  final double bottom;
  //Padding
  final double padding;

  const CustomChipsWidget({Key? key, required this.child, this.left = 0, this.right = 0, this.top = 0, this.bottom = 0, this.padding = 7}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: left, end: right, top: top, bottom: bottom),
      decoration: BoxDecoration(
        color: MyColor.cardBgLighGreyColor,
        borderRadius: BorderRadius.circular(Dimensions.space5),
        border: Border.all(color: MyColor.colorlighterGrey, width: 0.3),
      ),
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
