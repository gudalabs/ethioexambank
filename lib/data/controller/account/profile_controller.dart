import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/helper/shared_preference_helper.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/profile/profile_response_model.dart';
import 'package:quiz_lab/data/model/user_post_model/user_post_model.dart';
import 'package:quiz_lab/data/repo/account/profile_repo.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class ProfileController extends GetxController {
  ProfileRepo profileRepo;
  ProfileResponseModel model = ProfileResponseModel();

  ProfileController({required this.profileRepo});

  String imageUrl = '';

  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  late TextEditingController userNameController = TextEditingController(text: username.toString());
  late TextEditingController emailController = TextEditingController(text: email.toString());
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

  ApiClient get apiClient => profileRepo.apiClient;

  loadProfileInfo() async {
    if (username == '') {
      isLoading = true;
      update();
    }

    ResponseModel responseModel = await profileRepo.loadProfileInfo();
    if (responseModel.statusCode == 200) {
      model = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.data != null && model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        //save User Data
        profileRepo.apiClient.setUserData(model.data!.user!.toJson());
        loadData(model);
        username = model.data?.user?.username ?? '';
        rank = model.data?.rank?.userRank ?? '';
        coins = model.data?.user?.coins ?? '';
        score = model.data?.user?.score ?? '';
        avatar = model.data?.user?.avatar ?? '';
        email = model.data?.user?.email ?? '';

        //save User Data
        profileRepo.apiClient.setUserData(model.data!.user!.toJson());
      } else {
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      update();
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
  }

  bool isSubmitLoading = false;
  updateProfile() async {
    isSubmitLoading = true;
    update();

    String firstName = firstNameController.text;
    String lastName = lastNameController.text.toString();
    String address = addressController.text.toString();
    String city = cityController.text.toString();
    String zip = zipCodeController.text.toString();
    String state = stateController.text.toString();
    User? user = model.data?.user;

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      isLoading = true;
      update();

      UserPostModel model = UserPostModel(
        firstname: firstName,
        lastName: lastName,
        mobile: user?.mobile ?? '',
        email: user?.email ?? '',
        username: user?.username ?? '',
        countryCode: user?.countryCode ?? '',
        country: user?.address?.country ?? '',
        mobileCode: '880',
        avatar: imageFile,
        address: address,
        state: state,
        zip: zip,
        city: city,
      );

      bool b = await profileRepo.updateProfile(model, true);

      if (b) {
        await loadProfileInfo();
      }
    } else {
      if (firstName.isEmpty) {
        CustomSnackBar.error(errorList: [MyStrings.kFirstNameNullError.tr]);
      }
      if (lastName.isEmpty) {
        CustomSnackBar.error(errorList: [MyStrings.kLastNameNullError.tr]);
      }
    }

    isSubmitLoading = false;
    update();
  }

  void loadData(ProfileResponseModel? model) {
    profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${model?.data?.user?.username}');

    firstNameController.text = model?.data?.user?.firstname ?? '';
    lastNameController.text = model?.data?.user?.lastname ?? '';
    emailController.text = model?.data?.user?.email ?? '';
    mobileNoController.text = model?.data?.user?.mobile ?? '';
    addressController.text = model?.data?.user?.address?.address ?? '';
    stateController.text = model?.data?.user?.address?.state ?? '';
    zipCodeController.text = model?.data?.user?.address?.zip ?? '';
    cityController.text = model?.data?.user?.address?.city ?? '';
    imageUrl = model?.data?.user?.avatar == null ? '' : '${model?.data?.user?.avatar}';

    if (imageUrl.isNotEmpty && imageUrl != 'null') {
      imageUrl = '${UrlContainer.domainUrl}/assets/images/user/profile/$imageUrl';
    }

    isLoading = false;
    update();
  }
}
