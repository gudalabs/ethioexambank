import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
            child: Divider(
               thickness: .65,
          color: MyColor.colorLightGrey,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
          child: Text(
            MyStrings.or.tr,
            style: regularDefault.copyWith(color: MyColor.colorlighterGrey),
          ),
        ),
        const Expanded(
            child: Divider(
              thickness: .65,
          color: MyColor.colorLightGrey,
        )),
      ],
    );
  }
}
