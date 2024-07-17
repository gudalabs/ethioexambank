import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/account/profile_complete_controller.dart';
import 'package:quiz_lab/data/repo/account/profile_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_appbar.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:quiz_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:quiz_lab/view/components/will_pop_widget.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            title: MyStrings.profileComplete.tr,
            isShowBackBtn: true,
            fromAuth: false,
            isProfileCompleted: true,
            bgColor: MyColor.getAppBarColor(),
          ),
          body: GetBuilder<ProfileCompleteController>(
            builder: (controller) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: controller.isLoading
                  ? const CustomLoader()
                  : Container(
                      padding: const EdgeInsets.all(Dimensions.space20),
                      decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.space10)),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.space15),
                            Center(
                              child: SvgPicture.asset(
                                MyImages.appLogoSVG,
                                height: Dimensions.space60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: Dimensions.space30),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.firstName.tr,
                              hintText: "${MyStrings.enterYour.tr} ${MyStrings.firstName.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.firstNameFocusNode,
                              controller: controller.firstNameController,
                              nextFocus: controller.lastNameFocusNode,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.lastName.tr,
                              hintText: "${MyStrings.enterYour.tr} ${MyStrings.lastName.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.lastNameFocusNode,
                              controller: controller.lastNameController,
                              nextFocus: controller.addressFocusNode,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.address,
                              hintText: "${MyStrings.enterYour.tr} ${MyStrings.address.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.addressFocusNode,
                              controller: controller.addressController,
                              nextFocus: controller.stateFocusNode,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.state,
                              hintText: "${MyStrings.enterYour.tr} ${MyStrings.state.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.stateFocusNode,
                              controller: controller.stateController,
                              nextFocus: controller.cityFocusNode,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.city.tr,
                              hintText: "${MyStrings.enterYour.tr} ${MyStrings.city.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.cityFocusNode,
                              controller: controller.cityController,
                              nextFocus: controller.zipCodeFocusNode,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.zipCode.tr,
                              hintText: "${MyStrings.enterYour.tr} ${MyStrings.zipCode.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.done,
                              focusNode: controller.zipCodeFocusNode,
                              controller: controller.zipCodeController,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space35),
                            controller.submitLoading
                                ? const RoundedLoadingBtn()
                                : RoundedButton(
                                    text: MyStrings.updateProfile.tr,
                                    press: () {
                                      controller.updateProfile();
                                    },
                                  )
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
