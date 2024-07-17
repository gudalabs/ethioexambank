import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:quiz_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:quiz_lab/view/components/image_widget/my_image_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/style.dart';
import '../language-bottom-sheet/language_bottom_sheet_screen.dart';

class CustomHomeAppBar extends StatefulWidget {
  final double appbarSize;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomHomeAppBar(
      {super.key, required this.appbarSize, required this.scaffoldKey});

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.appbarSize < kToolbarHeight
          ? kToolbarHeight
          : widget.appbarSize,
      child: GetBuilder<DashBoardController>(
        builder: (controller) {
          return AppBar(
            leadingWidth: Dimensions.space30,
            leading: IconButton(
                onPressed: () {
                  widget.scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu)),
            flexibleSpace: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImages.appBarBGImage),
                    fit: BoxFit.fitWidth),
              ),
            ),
            backgroundColor: MyColor.primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (controller.userImage.toString() != "null" &&
                    controller.userImage.toString() != "")
                  SizedBox(
                    child: CircleAvatar(
                      backgroundColor: MyColor.colorWhite.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.space5),
                        child: MyImageWidget(
                          fromProfile: true,
                          radius: Dimensions.space100,
                          imageUrl: UrlContainer.dashboardUserProfileImage +
                              controller.userImage.toString(),
                        ),
                      ),
                    ),
                  )
                else
                  CircleAvatar(
                    radius: Dimensions.space22,
                    backgroundColor: MyColor.colorWhite.withOpacity(0.2),
                    child: Padding(
                        padding: const EdgeInsets.all(Dimensions.space5),
                        child: Image.asset(MyImages.defaultAvatar)),
                  ),
                const SizedBox(width: Dimensions.space10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // "${MyStrings.hi.tr} ${controller.dashRepo.apiClient.getCurrencyOrUsername(isCurrency: false)}",
                        "${MyStrings.hi.tr} ${controller.dashRepo.apiClient.getUserFullName()}",

                        style: semiBoldLarge.copyWith(
                            fontSize: Dimensions.fontMediumLarge,
                            color: MyColor.colorWhite),
                      ),
                      const SizedBox(height: Dimensions.space5),
                      Text(
                        MyStrings.letsPlayQuiz.tr,
                        style:
                            regularDefault.copyWith(color: MyColor.colorWhite),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.leaderBoardScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.space8),
                  child: SvgPicture.asset(MyImages.reward),
                ),
              ),
              InkWell(
                onTap: () {
                  CustomBottomSheet(child: const LanguageBottomSheetScreen())
                      .customBottomSheet(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.space8),
                  child: SvgPicture.asset(MyImages.languagesSVG),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
