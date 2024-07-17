import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:get/get.dart';
import '../../components/app-bar/custom_category_appbar.dart';
import 'widgets/exam_zone_tabbar_body_section.dart';

class ExamZoneScreen extends StatelessWidget {
  const ExamZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.exam.tr),
      body: const ExamZoneTabBarBodySection(),
    );
  }

}
