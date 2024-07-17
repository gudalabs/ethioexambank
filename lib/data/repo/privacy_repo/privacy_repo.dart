import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../services/api_client.dart';

class PrivacyRepo {
  ApiClient apiClient;
  PrivacyRepo({required this.apiClient});

  Future<dynamic> loadAboutData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.privacyPolicyEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }
}
