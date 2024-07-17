import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:get/get.dart';

import '../../../components/app-bar/custom_category_appbar.dart';
import 'find-opponets-widgets/find_oppnent_body_section.dart';

class FindOpponenetScreen extends StatelessWidget {
  const FindOpponenetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.letsPlay.tr),
      body: const SingleChildScrollView(physics: BouncingScrollPhysics(), child: FindOpponentsBodySection()),
    );
  }
}
