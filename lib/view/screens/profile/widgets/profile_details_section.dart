import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/account/profile_controller.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';

import '../../../../core/utils/my_images.dart';
import '../../../../data/controller/auth/logout/logout_controller.dart';
import '../../../components/dialog/warning_dialog.dart';

class ProfileDetailsSection extends StatefulWidget {
  const ProfileDetailsSection({super.key});

  @override
  State<ProfileDetailsSection> createState() => _ProfileDetailsSectionState();
}

class _ProfileDetailsSectionState extends State<ProfileDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(Dimensions.space18),
        child: (controller.isLoading == true)
            ? Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: context.width * 0.15),
                child: const CustomLoader())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimensions.space10),
                  Container(
                    decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius:
                            BorderRadius.circular(Dimensions.space10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.space16),
                          child: Text(
                            MyStrings.profileDetails.tr,
                            style: boldMediumLarge,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            MyStrings.fullname.tr,
                            style: regularDefault.copyWith(
                                color: MyColor.textColor),
                          ),
                          subtitle: Text(
                              controller.profileRepo.apiClient
                                  .getUserFullName()
                                  .tr,
                              style: semiBoldLarge.copyWith(
                                  color: MyColor.colorBlack,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const Divider(height: Dimensions.space3),
                        ListTile(
                          title: Text(
                            MyStrings.emailAddress.tr,
                            style: regularDefault.copyWith(
                                color: MyColor.textColor),
                          ),
                          subtitle: Text(controller.emailController.text,
                              style: semiBoldLarge.copyWith(
                                  color: MyColor.colorBlack,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const Divider(height: Dimensions.space3),
                        ListTile(
                          title: Text(
                            MyStrings.address.tr,
                            style: regularDefault.copyWith(
                                color: MyColor.textColor),
                          ),
                          subtitle: Text(controller.addressController.text.tr,
                              style: semiBoldLarge.copyWith(
                                  color: MyColor.colorBlack,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const Divider(height: Dimensions.space3),
                        ListTile(
                          title: Text(
                            MyStrings.city.tr,
                            style: regularDefault.copyWith(
                                color: MyColor.textColor),
                          ),
                          subtitle: Text(controller.cityController.text.tr,
                              style: semiBoldLarge.copyWith(
                                  color: MyColor.colorBlack,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.space20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius:
                            BorderRadius.circular(Dimensions.space10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.space16),
                          child: Text(
                            MyStrings.accountControl.tr,
                            style: boldMediumLarge,
                          ),
                        ),
                        GetBuilder<LogoutController>(
                          builder: (logoutController) {
                            return ListTile(
                              onTap: () {
                                const WarningAlertDialog()
                                    .deleteAccountAlertDialog(context, () {
                                  print("Delete Button Clicked!");
                                  Get.back();
                                  logoutController.deleteMyAccount();
                                });
                              },
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  MyStrings.deleteAccount.tr,
                                  style: regularDefault.copyWith(
                                      color: MyColor.colorRed,
                                      fontSize: Dimensions.fontExtraLarge),
                                ),
                              ),
                              subtitle: Text(MyStrings.deleteAccountMSG.tr,
                                  style: semiBoldLarge.copyWith(
                                      color: MyColor.colorBlack,
                                      fontWeight: FontWeight.w500)),
                              trailing: logoutController.accountDeleteStarted
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
                                      colorFilter: const ColorFilter.mode(
                                          MyColor.wrongAnsColor,
                                          BlendMode.srcIn),
                                      width: Dimensions.space35,
                                    ),
                            );
                          },
                        ),
                        const Divider(height: Dimensions.space10),
                        GetBuilder<LogoutController>(
                          builder: (logoutController) {
                            return ListTile(
                              onTap: () {
                                const WarningAlertDialog()
                                    .warningAlertDialog(context, () {
                                  Get.back();
                                  logoutController.logout();
                                }, title: MyStrings.logoutSureWarningMSg);
                              },
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  MyStrings.logoutTitle.tr,
                                  style: regularDefault.copyWith(
                                      color: MyColor.colorRed,
                                      fontSize: Dimensions.fontExtraLarge),
                                ),
                              ),
                              subtitle: Text(MyStrings.logoutMSg.tr,
                                  style: semiBoldLarge.copyWith(
                                      color: MyColor.colorBlack,
                                      fontWeight: FontWeight.w500)),
                              trailing: logoutController.loaderStarted
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
                                      colorFilter: const ColorFilter.mode(
                                          MyColor.wrongAnsColor,
                                          BlendMode.srcIn),
                                      width: Dimensions.space30,
                                    ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: Dimensions.space20,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.addSpace,
                  ),
                ],
              ),
      ),
    );
  }
}
