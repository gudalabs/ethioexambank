import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';

import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/util.dart';
import 'package:quiz_lab/data/controller/localization/localization_controller.dart';
import 'package:quiz_lab/data/controller/splash/splash_controller.dart';
import 'package:quiz_lab/data/repo/auth/general_setting_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    MyUtils.splashScreen();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(SplashController(repo: Get.find(), localizationController: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.primaryColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                MyImages.splashBGImage,
                fit: BoxFit.cover, // Make the image cover the full width
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.space35),
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  MyImages.splashLogoSVG,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
