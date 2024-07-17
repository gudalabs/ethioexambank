import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz_lab/core/helper/shared_preference_helper.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/authorization/authorization_response_model.dart';
import 'package:quiz_lab/data/model/general_setting/general_setting_response_model.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';

class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;
  String backendUrl =
      'http://www.ethioexambank.com/api'; // Add your backend URL here
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(backendUrl +
        uri); // Replace the existing URL variable with the parsed URL
    http.Response response;

    try {
      if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          if (isOnlyAcceptType) {
            response = await http.post(url, body: params, headers: {
              "Accept": "application/json",
            });
          } else {
            response = await http.post(url, body: params, headers: {
              "Accept": "application/json",
              "Authorization": "$tokenType $token"
            });
          }
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.updateMethod) {
        if (passHeader) {
          initToken();

          response = await http.post(url, body: params, headers: {
            "Accept": "application/json",
            "Authorization": "$tokenType $token"
          });
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();

          response = await http.get(url, headers: {
            "Accept": "application/json",
            "Authorization": "$tokenType $token"
          });
          if (response.body.isEmpty) {
            response = await http
                .get(url, headers: {"Authorization": "$tokenType $token"});
          }
        } else {
          response = await http.get(
            url,
          );
        }
      }

      debugPrint('url--------------${uri.toString()}');
      debugPrint('params-----------${params.toString()}');
      debugPrint('status-----------${response.statusCode}');
      debugPrint('body-------------${response.body.toString()}');
      debugPrint('token------------$token');

      if (response.statusCode == 200) {
        try {
          AuthorizationResponseModel model =
              AuthorizationResponseModel.fromJson(jsonDecode(response.body));
          if (model.remark!.toLowerCase() == 'unauthenticated') {
            sharedPreferences.setBool(
                SharedPreferenceHelper.rememberMeKey, false);
            sharedPreferences.remove(SharedPreferenceHelper.token);
            Get.offAllNamed(RouteHelper.loginScreen);
          }
        } catch (e) {
          return ResponseModel(false, 'error', 404, "{}");
        }

        return ResponseModel(true, 'success', 200, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(
            false, MyStrings.unAuthorized.tr, 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(
            false, MyStrings.serverError.tr, 500, response.body);
      } else {
        return ResponseModel(
            false, MyStrings.somethingWentWrong.tr, 499, response.body);
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
  }

  String token = '';
  String tokenType = '';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t =
          sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType =
          sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  storeGeneralSetting(GeneralSettingResponseModel model) {
    String json = jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingResponseModel getGSData() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingResponseModel model =
        GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    return model;
  }

  String getCurrencyOrUsername(
      {bool isCurrency = true, bool isSymbol = false}) {
    if (isCurrency) {
      String pre = sharedPreferences
              .getString(SharedPreferenceHelper.generalSettingKey) ??
          '';
      GeneralSettingResponseModel model =
          GeneralSettingResponseModel.fromJson(jsonDecode(pre));
      String currency = isSymbol
          ? model.data?.generalSetting?.curSym ?? ''
          : model.data?.generalSetting?.curText ?? '';
      return currency;
    } else {
      String username =
          sharedPreferences.getString(SharedPreferenceHelper.userNameKey) ?? '';
      return username;
    }
  }

  Future setUserData(value) async {
    await sharedPreferences
        .setString(SharedPreferenceHelper.userDataKey, jsonEncode(value))
        .whenComplete(() {
      debugPrint("USer Data Saved");
    });
  }

  Map<String, dynamic> getUserData() {
    String userdata =
        sharedPreferences.getString(SharedPreferenceHelper.userDataKey) ?? '';
    return userdata == '' ? {} : jsonDecode(userdata);
  }

  String getUserEmail() {
    String email =
        sharedPreferences.getString(SharedPreferenceHelper.userEmailKey) ?? '';
    return email;
  }

  String getUserName() {
    String username =
        sharedPreferences.getString(SharedPreferenceHelper.userNameKey) ?? '';
    return username;
  }

  String getUserFullName() {
    var userData = getUserData();
    return "${userData['firstname'] ?? ''} ${userData['lastname'] ?? ''} ";
  }

  String getUserImagePath() {
    var userData = getUserData();
    return "${userData['avatar']}";
  }

  String getUserCurrentCoin() {
    var userData = getUserData();
    return "${userData['coins']}";
  }

  String getUserCurrentScore() {
    var userData = getUserData();
    return "${userData['12']}";
  }

  String getUserID() {
    String userID =
        sharedPreferences.getString(SharedPreferenceHelper.userIdKey) ?? '';
    return userID;
  }

  bool getPasswordStrengthStatus() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingResponseModel model =
        GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    bool checkPasswordStrength =
        model.data?.generalSetting?.securePassword.toString() == '0'
            ? false
            : true;
    return checkPasswordStrength;
  }

  String getTemplateName() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingResponseModel model =
        GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    String templateName = model.data?.generalSetting?.activeTemplate ?? '';
    return templateName;
  }

  Future<void> setSoundStatus(bool value) async {
    await sharedPreferences.setBool(SharedPreferenceHelper.soundKey, value);
  }

  bool getSoundStatus() {
    return sharedPreferences.getBool(SharedPreferenceHelper.soundKey) ?? false;
  }

  Future setVibrationStatus(bool value) async {
    await sharedPreferences.setBool(SharedPreferenceHelper.vibrationKey, value);
  }

  bool getVibrationStatus() {
    return sharedPreferences.getBool(SharedPreferenceHelper.vibrationKey) ??
        false;
  }

  Future setTheme(bool value) async {
    await sharedPreferences.setBool(SharedPreferenceHelper.themeKey, value);
  }

  String getSocialLoginActiveStats(String type) {
    if (type == 'phone') {
      return getGSData().data?.generalSetting?.mobileLogin ?? '';
    } else if (type == 'google') {
      return getGSData().data?.generalSetting?.googleLogin ?? '';
    }
    return '0';
  }
}
