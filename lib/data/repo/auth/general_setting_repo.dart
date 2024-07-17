
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';

class GeneralSettingRepo {
  ApiClient apiClient;
  GeneralSettingRepo({required this.apiClient});

  Future<dynamic> getGeneralSetting() async {
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
    ResponseModel response =
        await apiClient.request(url, Method.getMethod, null, passHeader: false);
    return response;
  }

  Future<dynamic> getLanguage(String languageCode) async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.changeLanguageUrl}$languageCode';
      ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: false);

      return response;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }
  }
  Future<dynamic> changeLanguage(String languageCode) async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.changeLanguageUrl}$languageCode';
      ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: false);

      return response;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }
  }
}
