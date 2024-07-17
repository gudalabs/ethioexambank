import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:get/get.dart';

import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';

class CustomSignUPText extends StatelessWidget {
  const CustomSignUPText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
              decoration: const  BoxDecoration(
                border: Border(
                bottom: BorderSide(color: MyColor.primaryColor, ))
              ),
              child:  Text(
              MyStrings.signUp.tr,
              style: regularMediumLarge.copyWith(color:MyColor.primaryColor,
              fontSize: Dimensions.space14  
              ),
            ),
          );
  }
}