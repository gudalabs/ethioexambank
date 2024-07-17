import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/view/screens/authentication/forget_password/resetPassword/widget/resetpassword_body_section.dart';

import '../../../../components/custom-head-section-for-auth/auth_heading.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
             ResetPasswordBodySection(),
            ],
          ),
        ),
      ),
    );
  }
}