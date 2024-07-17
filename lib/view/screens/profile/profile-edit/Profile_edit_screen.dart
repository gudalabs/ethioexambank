import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/account/profile_update_controller.dart';
import 'package:quiz_lab/data/repo/account/profile_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/divider/custom_divider.dart';
import 'package:quiz_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/buttons/rounded_loading_button.dart';
import 'profile_image.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String selectedAvatar = '';
  XFile? imageFile;

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));

    var controller = Get.put(ProfileUpdateController(profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(
        title: MyStrings.editProfile.tr,
      ),
      body: GetBuilder<ProfileUpdateController>(
        builder: (controller) => controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: const EdgeInsetsDirectional.only(
                    top: Dimensions.space40,
                    end: Dimensions.space18,
                    start: Dimensions.space18),
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.space16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: MyColor.colorWhite,
                      borderRadius: BorderRadius.circular(Dimensions.space10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          FittedBox(
                            fit: BoxFit.cover,
                            child: ProfileWidget(
                              isEdit: true,
                              imagePath: controller.imageUrl,
                              onClicked: () async {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.space10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.space8),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(MyStrings.profileDetails.tr,
                                  style: semiBoldExtraLarge),
                            ),
                            const CustomDivider(
                              space: Dimensions.space10,
                            ),
                            CustomTextField(
                              controller: controller.userNameController,
                              onChanged: () {},
                              needOutlineBorder: true,
                              hintText: MyStrings.username,
                              readOnly: false,
                              prefixicon: MyImages.personSVG,
                              hasIcon: true,
                              animatedLabel: true,
                              hastextcolor: false,
                              fontColor: MyColor.colorBlack,
                            ),
                            const CustomDivider(space: Dimensions.space10),
                            CustomTextField(
                              controller: controller.firstNameController,
                              onChanged: () {},
                              needOutlineBorder: true,
                              hintText: MyStrings.firstName,
                              readOnly: false,
                              prefixicon: MyImages.personSVG,
                              hasIcon: true,
                              animatedLabel: true,
                              hastextcolor: false,
                              fontColor: MyColor.colorBlack,
                            ),
                            const CustomDivider(space: Dimensions.space10),
                            CustomTextField(
                              controller: controller.lastNameController,
                              onChanged: () {},
                              needOutlineBorder: true,
                              hintText: MyStrings.lastName,
                              readOnly: false,
                              prefixicon: MyImages.personSVG,
                              hasIcon: true,
                              animatedLabel: true,
                              hastextcolor: false,
                              fontColor: MyColor.colorBlack,
                            ),
                            const CustomDivider(space: Dimensions.space10),
                            CustomTextField(
                              controller: controller.emailController,
                              onChanged: () {},
                              needOutlineBorder: true,
                              hintText: MyStrings.email,
                              readOnly: true,
                              prefixicon: MyImages.mailSVG,
                              hasIcon: true,
                              animatedLabel: true,
                              hastextcolor: false,
                              fontColor: MyColor.colorBlack,
                            ),
                            const CustomDivider(space: Dimensions.space10),
                            CustomTextField(
                              controller: controller.addressController,
                              onChanged: () {},
                              needOutlineBorder: true,
                              hintText: MyStrings.address,
                              readOnly: false,
                              prefixicon: MyImages.addressSVG,
                              hasIcon: true,
                              animatedLabel: true,
                              hastextcolor: false,
                              fontColor: MyColor.colorBlack,
                            ),
                            const CustomDivider(space: Dimensions.space10),
                            CustomTextField(
                              controller: controller.stateController,
                              onChanged: () {},
                              needOutlineBorder: true,
                              hintText: MyStrings.state,
                              readOnly: false,
                              prefixicon: MyImages.addressSVG,
                              hasIcon: true,
                              animatedLabel: true,
                              hastextcolor: false,
                              fontColor: MyColor.colorBlack,
                            ),
                            const CustomDivider(space: Dimensions.space10),
                            CustomTextField(
                              controller: controller.zipCodeController,
                              onChanged: () {},
                              needOutlineBorder: true,
                              hintText: MyStrings.zipCode,
                              readOnly: false,
                              prefixicon: MyImages.addressSVG,
                              hasIcon: true,
                              animatedLabel: true,
                              hastextcolor: false,
                              fontColor: MyColor.colorBlack,
                            ),
                            const CustomDivider(space: Dimensions.space10),
                            CustomTextField(
                              controller: controller.cityController,
                              onChanged: () {},
                              needOutlineBorder: true,
                              hintText: MyStrings.city,
                              readOnly: false,
                              prefixicon: MyImages.addressSVG,
                              hasIcon: true,
                              animatedLabel: true,
                              hastextcolor: false,
                              fontColor: MyColor.colorBlack,
                            ),
                            const CustomDivider(space: Dimensions.space10),
                            if (controller.isSubmitLoading)
                              const RoundedLoadingBtn()
                            else
                              RoundedButton(
                                text: MyStrings.updateProfile.tr,
                                press: () {
                                  controller.updateProfileData();
                                },
                                textSize: Dimensions.space17,
                                verticalPadding: Dimensions.space16,
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
