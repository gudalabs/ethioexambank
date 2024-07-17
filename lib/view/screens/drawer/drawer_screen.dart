import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';

import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/auth/logout/logout_controller.dart';
import 'package:quiz_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:quiz_lab/data/repo/auth/logout/logout_repo.dart';

import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/screens/home_page/homepage-widgets/language-bottom-sheet/language_bottom_sheet_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/util.dart';
import '../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../components/dialog/warning_dialog.dart';
import '../../components/image_widget/my_image_widget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LogoutRepo(apiClient: Get.find()));
    Get.put(LogoutController(logoutRepo: Get.find()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _scaffoldKey,
      child: Column(
        children: [
          GetBuilder<DashBoardController>(
            builder: (controller) => Container(
              padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: Dimensions.space30, start: Dimensions.space20),
                child: Row(children: [
                  if (controller.userImage.toString() != "null")
                    SizedBox(
                      child: CircleAvatar(
                        backgroundColor: MyColor.primaryColor.withOpacity(0.2),
                        child: MyImageWidget(
                          radius: Dimensions.space100,
                          imageUrl: UrlContainer.dashboardUserProfileImage + controller.userImage.toString(),
                        ),
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: Dimensions.space22,
                      backgroundColor: MyColor.primaryColor.withOpacity(0.2),
                      child: Image.asset(MyImages.defaultAvatar),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: Dimensions.space20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.dashRepo.apiClient.getCurrencyOrUsername(isCurrency: false),
                            style: semiBoldMediumLarge,
                          ),
                          const SizedBox(height: Dimensions.space7),
                          Text("${MyStrings.totalCoin.tr} - ${MyUtils().formatNumberWithLeadingZero(controller.coins.tr)}", style: semiBoldLarge.copyWith(color: MyColor.primaryColor, fontSize: Dimensions.fontDefault12))
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ListTile(
                  leading: SvgPicture.asset(MyImages.profileDrawer),
                  title: Text(
                    MyStrings.profile.tr,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    Get.toNamed(RouteHelper.profileScreen);
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.coinStoreDrawer),
                  title: Text(
                    MyStrings.coinStore.tr,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    Get.toNamed(RouteHelper.coinStroeScreen);
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.coinStoreDrawer),
                  title: Text(
                    MyStrings.coinHistory.tr,
                    style: regularMediumLarge,
                  ),
                  onTap: () {
                    Get.toNamed(RouteHelper.coinHistoryScreen);
                  },
                  minLeadingWidth: Dimensions.space1,
                ),
                if (Get.find<DashBoardController>().dailyQuizStatus == '1' || Get.find<DashBoardController>().singleBattleStatus == '1')
                  const Divider(
                    endIndent: Dimensions.space70,
                  ),
                if (Get.find<DashBoardController>().dailyQuizStatus == '1')
                  ListTile(
                    leading: SvgPicture.asset(
                      MyImages.dailyQuizDrawer,
                      width: 25,
                    ),
                    title: Text(
                      MyStrings.dailyQuiz.tr,
                      style: regularMediumLarge,
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.dailyQuizQuestionsScreen);
                    },
                    minLeadingWidth: Dimensions.space1,
                  ),
                if (Get.find<DashBoardController>().singleBattleStatus == '1')
                  ListTile(
                    leading: SvgPicture.asset(
                      MyImages.singleBattleDrawer,
                      width: 25,
                    ),
                    title: Text(
                      MyStrings.singleBattle.tr,
                      style: regularMediumLarge,
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.oneVSoneBattleScreen);
                    },
                    minLeadingWidth: Dimensions.space1,
                  ),
                const Divider(
                  endIndent: Dimensions.space70,
                ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.languageDrawer),
                  title: Text(
                    MyStrings.language.tr,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    CustomBottomSheet(child: const LanguageBottomSheetScreen()).customBottomSheet(context);
                  },
                ),
                GetBuilder<LogoutController>(
                  builder: (logoutController) => ListTile(
                    onTap: () {
                      const WarningAlertDialog().warningAlertDialog(context, () {
                        Get.back();
                        logoutController.logout();
                      }, title: MyStrings.logoutSureWarningMSg);
                    },
                    leading: logoutController.loaderStarted
                      ? const SizedBox(
                          width: Dimensions.space25,
                          height: Dimensions.space25,
                          child: SpinKitPouringHourGlass(
                            strokeWidth: 0.2,
                            color: MyColor.primaryColor,
                            size: Dimensions.space40,
                          ),
                        )
                      : SvgPicture.asset(
                          MyImages.logOutDrawer,
                          width: Dimensions.space20,
                        ),
                    title: Text(
                      MyStrings.logout.tr,
                      style: regularMediumLarge,
                    ),
                    minLeadingWidth: Dimensions.space1,
                  ),
                ),
                GetBuilder<LogoutController>(builder: (logoutController) {
                  return ListTile(
                    leading: logoutController.accountDeleteStarted
                        ? const SizedBox(
                            width: Dimensions.space25,
                            height: Dimensions.space25,
                            child: SpinKitPouringHourGlass(
                              strokeWidth: 0.2,
                              color: MyColor.primaryColor,
                              size: Dimensions.space40,
                            ),
                          )
                        : SvgPicture.asset(
                            MyImages.accountDelete,
                            colorFilter: const ColorFilter.mode(MyColor.wrongAnsColor, BlendMode.srcIn),
                            width: 25,
                          ),
                    title: Text(
                      MyStrings.deleteAccount.tr,
                      style: regularMediumLarge.copyWith(color: MyColor.wrongAnsColor),
                    ),
                    onTap: () {
                      const WarningAlertDialog().deleteAccountAlertDialog(context, () {
                        Get.back();
                        logoutController.deleteMyAccount();
                      });
                    },
                    minLeadingWidth: Dimensions.space1,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
