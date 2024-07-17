import 'package:quiz_lab/core/helper/shared_preference_helper.dart';
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';

class LogoutRepo {
  ApiClient apiClient;

  LogoutRepo({required this.apiClient});

  Future<ResponseModel> logout() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.logoutUrl}';

    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    await clearSharedPrefData();
    return responseModel;
  }

  Future<void> clearSharedPrefData() async {
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    await apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    return Future.value();
  }

  Future<ResponseModel> deleteMyAccount() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.deleteAccountEndPoint}';

    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    await clearSharedPrefData();
    return responseModel;
  }
}
