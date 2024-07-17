import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_strings.dart';

class BottomSectionButtons extends StatelessWidget {
  const BottomSectionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Padding(
          padding: const EdgeInsets.all(Dimensions.space15),
          child: RoundedButton(
            text: MyStrings.home.tr,
            press: () {
              Get.offAllNamed(RouteHelper.bottomNavBarScreen);
            },
            color: MyColor.colorBlack,
            textSize: Dimensions.space21,
          ),
        )
        
      ],
    );
  }
}
