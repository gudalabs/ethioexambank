import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/account/profile_controller.dart';
import 'package:quiz_lab/data/repo/account/profile_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:get/get.dart';

import '../../../data/controller/auth/logout/logout_controller.dart';
import 'widgets/profile_details_section.dart';
import 'widgets/profile_overall_achivements_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    Get.put(LogoutController(logoutRepo: Get.find()));
    ProfileController controller = Get.put(ProfileController(profileRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });

  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CustomCategoryAppBar(
          title: MyStrings.profile.tr,
        ),
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ProfileTopSection(),
              ProfileDetailsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
