import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../components/custom-head-section-for-auth/auth_heading.dart';
import 'widget/verification_body_section.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        backgroundColor: MyColor.colorWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeadSection(height: Dimensions.space150,iconPosition: Dimensions.space60),
              VerificationBodySection(),
            ],
          ),
        ),
      ),
    );
  }
}