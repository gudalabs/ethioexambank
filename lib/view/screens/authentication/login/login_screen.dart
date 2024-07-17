import 'package:flutter/material.dart';
import 'package:quiz_lab/view/components/custom-head-section-for-auth/auth_heading.dart';
import 'package:quiz_lab/view/screens/authentication/login/widgets/login_body_section_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomHeadSection(
                height: MediaQuery.of(context).size.height * .31,
                hasBackButton: false,
                iconHasSize: true,
                iconPosition: MediaQuery.of(context).size.height * .12,
              ),
              const LoginBodySection(),
            ],
          ),
        ),
      ),
    );
  }
}
