import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/view/components/custom-head-section-for-auth/auth_heading.dart';
import 'package:quiz_lab/view/screens/authentication/signUp/signup_widgets/sign_up_body_section.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        backgroundColor: MyColor.colorWhite,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomHeadSection(height: Dimensions.space150, iconPosition: Dimensions.space60),
              SignUpBodySection(),
            ],
          ),
        ),
      ),
    );
  }
}
