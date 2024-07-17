import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/helper/shared_preference_helper.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/profile/profile_response_model.dart';
import 'package:quiz_lab/data/repo/account/profile_repo.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

import '../../model/user_post_model/user_post_model.dart';

class ProfileUpdateController extends GetxController {
  ProfileRepo profileRepo;
  ProfileResponseModel model = ProfileResponseModel();

  ProfileUpdateController({required this.profileRepo});

  String imageUrl = '';

  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  late TextEditingController userNameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  File? imageFile;

  String username = "";
  String coins = "";
  String rank = "";
  String score = "";
  String avatar = "";
  String email = "";

  loadProfileInfo() async {
    isLoading = true;
    update();
    ResponseModel responseModel = await profileRepo.loadProfileInfo();
    if (responseModel.statusCode == 200) {
      model = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.data != null && model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        //save User Data
        profileRepo.apiClient.setUserData(model.data!.user!.toJson());
        loadData(model);
        username = model.data!.user!.username!;
        rank = model.data!.rank!.userRank!;
        coins = model.data!.user!.coins!;
        score = model.data!.user!.score!;
        avatar = model.data!.user!.avatar!;
        email = model.data!.user!.email!;
      } else {
        isLoading = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
  }

  bool isSubmitLoading = false;
  updateProfilePic() async {
    isSubmitLoading = true;
    update();

    bool b = await profileRepo.updateProfilePicture(imageFile!);

    if (b) {
      await loadProfileInfo();
    }

    isSubmitLoading = false;
    update();
  }

  updateProfileData() async {
    isSubmitLoading = true;
    update();

    var userData = UserPostModel(
      firstname: firstNameController.text,
      lastName: lastNameController.text,
      address: addressController.text,
      state: stateController.text,
      zip: zipCodeController.text,
      city: cityController.text,
      avatar: imageFile,
    );

    bool b = await profileRepo.updateProfile(userData, true);

    if (b) {
      await loadProfileInfo();
    }
    isSubmitLoading = false;
    update();
  }

  void loadData(ProfileResponseModel? model) {
    profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${model?.data?.user?.username}');

    firstNameController.text = model?.data?.user?.firstname ?? '';
    lastNameController.text = model?.data?.user?.lastname ?? '';

    userNameController.text = model?.data?.user?.username ?? '';
    emailController.text = model?.data?.user?.email ?? '';
    mobileNoController.text = model?.data?.user?.mobile ?? '';
    addressController.text = model?.data?.user?.address?.address ?? '';
    stateController.text = model?.data?.user?.address?.state ?? '';
    zipCodeController.text = model?.data?.user?.address?.zip ?? '';
    cityController.text = model?.data?.user?.address?.city ?? '';
    imageUrl = model?.data?.user?.avatar == null ? '' : '${model?.data?.user?.avatar}';

    if (imageUrl.isNotEmpty && imageUrl != 'null') {
      imageUrl = '${UrlContainer.dashboardUserProfileImage}$imageUrl';
    }

    isLoading = false;
    update();
  }
}
