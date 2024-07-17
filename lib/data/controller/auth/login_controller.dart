import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_lab/environment.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/helper/shared_preference_helper.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/auth/login/login_response_model.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/repo/auth/login_repo.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/country_model/country_model.dart';

class LoginController extends GetxController {
  LoginRepo loginRepo;
  LoginController({required this.loginRepo});
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser.obs; // Observe the user
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode mobileNumberFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  String? email;
  String? password;

  List<String> errors = [];
  bool remember = false;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.value = firebaseAuth.currentUser;
    firebaseAuth.authStateChanges().listen((user) {
      firebaseUser.value = user;
    });
  }

  void forgetPassword() {
    Get.toNamed(RouteHelper.forgetpasswordScreen);
  }

  Future<void> checkAndGotoNextStep(LoginResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification = responseModel.data?.user?.sv == '1' ? false : true;

    if (remember) {
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userIdKey, responseModel.data?.user?.id.toString() ?? '-1');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, responseModel.data?.accessToken ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, responseModel.data?.tokenType ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, responseModel.data?.user?.email ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, responseModel.data?.user?.mobile ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, responseModel.data?.user?.username ?? '');
    await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.soundKey, true);
    await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.vibrationKey, true);


    await loginRepo.sendUserToken();

    bool isProfileCompleteEnable = responseModel.data?.user?.regStep == '0' ? true : false;

    if (needSmsVerification == false && needEmailVerification == false) {
      if (isProfileCompleteEnable) {
        Get.offAndToNamed(RouteHelper.profileCompleteScreen);
      } else {
        Get.offAndToNamed(RouteHelper.bottomNavBarScreen);
      }
    } else if (needSmsVerification == true && needEmailVerification == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [true, isProfileCompleteEnable]);
    } else if (needSmsVerification == true && needEmailVerification == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [true, isProfileCompleteEnable]);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen, arguments: [isProfileCompleteEnable]);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [false, isProfileCompleteEnable]);
    }

    if (remember) {
      changeRememberMe();
    }
  }

  bool isSubmitLoading = false;
  void loginUser() async {
    isSubmitLoading = true;
    update();

    ResponseModel model = await loginRepo.loginUser(emailController.text.toString(), passwordController.text.toString());

    if (model.statusCode == 200) {
      LoginResponseModel loginModel = LoginResponseModel.fromJson(jsonDecode(model.responseJson));
      if (loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        await checkAndGotoNextStep(loginModel);
      } else {
        CustomSnackBar.error(errorList: loginModel.message?.error ?? [MyStrings.loginFailedTryAgain.tr]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSubmitLoading = false;
    update();
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';

    if (remember) {
      remember = false;
    }
    update();
  }


  initMobileAuthData() async {
    resetOtpPageData();
    await getCountryData();
  }

  RxString verificationId = ''.obs;
  bool sendOtpButtonLoading = false;
  bool isInOTPpage = false;
  bool isResendingOTP = false;
  final secondLeft = 0.obs;
  bool isSocailSubmitLoading = false;

  Timer? _resendTimer;
  Timer? get resendTimer => _resendTimer;
  //to manage the search input.
  TextEditingController searchController = TextEditingController();
  TextEditingController otpFiledController = TextEditingController();
  //mian Counntry list

  List<Countries> countryList = [];
  //to hold the countries matching the search.
  List<Countries> filteredCountries = [];

  Countries selectedCountryData = Countries();

  bool countryLoading = true;
  bool phoneNumberValidate = true;

// GET Country Data first
  Future<dynamic> getCountryData() async {
    ResponseModel mainResponse = await loginRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      countryList.clear();
      CountryModel model = CountryModel.fromJson(jsonDecode(mainResponse.responseJson));
      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
      }

      var selectDefCountry = tempList!.firstWhere((country) => country.countryCode!.toLowerCase() == Environment.defaultCountryCode.toLowerCase(), orElse: () => Countries());

      if (selectDefCountry.dialCode != null) {
        selectCountryData(selectDefCountry);
      }
    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);
    }

    countryLoading = false;
    update();
  }

  selectCountryData(Countries value) {
    selectedCountryData = value;
    update();
  }

  validatePhoneNumber(bool value) {
    phoneNumberValidate = value;
    update();
  }

  changeOtpSendButtonLoading(bool value) {
    sendOtpButtonLoading = value;
    update();
  }

  changeOtpPageStatus(bool value) {
    isInOTPpage = value;
    update();
  }

  resetOtpPageData() {
    phoneNumberValidate = true;
    isInOTPpage = false;
    sendOtpButtonLoading = false;
    isResendingOTP = false;
    secondLeft.value = 0;
    otpFiledController = TextEditingController();
    mobileNumberController = TextEditingController();
    update();
  }

  Future<void> verifyPhoneNumber({bool loader = true}) async {
    try {
      changeOtpSendButtonLoading(loader);
      String phoneNumber = "${MyStrings.plusText.tr}${selectedCountryData.dialCode!.tr}${mobileNumberController.text.tr}";

      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in the user if verification is complete
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          changeOtpSendButtonLoading(false);

          CustomSnackBar.error(errorList: [e.message!]);
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          debugPrint("Go To OTP PAGE");
          changeOtpPageStatus(true);

          changeOtpSendButtonLoading(false);
          CustomSnackBar.success(successList: [MyStrings.otpSentToYourMobile.tr]);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
          changeOtpSendButtonLoading(false);
        },
      );
    } catch (e) {
      changeOtpSendButtonLoading(false);
      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

  Future<void> signInWithOTP(String otp) async {
    try {
      changeOtpSendButtonLoading(true);
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await firebaseAuth.signInWithCredential(credential);

      await socialLoginUser(mobile: firebaseUser.value!.phoneNumber, uid: firebaseUser.value!.uid, provider: 'mobile');

      changeOtpSendButtonLoading(false);
    } catch (e) {
      changeOtpSendButtonLoading(false);
      if (e.toString().contains("invalid-verification-code]")) {
        CustomSnackBar.error(errorList: [MyStrings.pleaseEnterValidOtpCode.tr]);
      }

      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

  Future<void> resendOTP() async {
    try {
      if (isResendingOTP == false) {
        if (_resendTimer != null && _resendTimer!.isActive) {
          debugPrint("cancle timmer");
          _resendTimer!.cancel();
        }
        await verifyPhoneNumber(loader: false);
        isResendingOTP = true;
        _startResendTimer();
      } else {
        CustomSnackBar.error(errorList: ["${MyStrings.tryAfterSec.tr} ${secondLeft.value.toString()} ${MyStrings.seconds.tr}"]);
      }
    } catch (e) {
      CustomSnackBar.error(errorList: [e.toString()]);
      isResendingOTP = false;
    }
  }

  void _startResendTimer() {
    secondLeft.value = Environment.otpResendSecond;
    update();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      isResendingOTP = true;
      secondLeft.value--;

      if (secondLeft.value <= 0) {
        isResendingOTP = false;
        _resendTimer?.cancel();
      }
    });
    update();
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> signOutGoogleAuth() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

  //SIGN IN With Google

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // throw Exception('Google Sign-In canceled by user');
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);

      await socialLoginUser(email: firebaseUser.value!.email, uid: firebaseUser.value!.uid, provider: 'email');
      await googleSignIn.signOut();
    } catch (e) {
      // debugPrint(e.toString());

      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

  //Social Login API PART

  Future socialLoginUser({String? email, String? mobile, String? provider, String? uid}) async {
    isSocailSubmitLoading = true;

    update();

    late ResponseModel responseModel;

    if (provider == "email") {
      responseModel = await loginRepo.socialLoginUser(
        email: email,
        provider: provider,
        uid: uid,
      );
    }
    if (provider == "mobile") {
      responseModel = await loginRepo.socialLoginUser(
        mobile: mobile,
        provider: provider,
        uid: uid,
      );
    }

    if (responseModel.statusCode == 200) {
      LoginResponseModel loginModel = LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        remember = true;
        update();
        await checkAndGotoNextStep(loginModel);
      } else {
        CustomSnackBar.error(errorList: loginModel.message?.error ?? [MyStrings.loginFailedTryAgain.tr]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isSocailSubmitLoading = false;
    update();
  }
  //Firebase Login part
}
