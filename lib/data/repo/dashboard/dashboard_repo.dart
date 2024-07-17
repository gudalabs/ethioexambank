import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';

class DashBoardRepo {
  ApiClient apiClient;
  DashBoardRepo({required this.apiClient});

  Future<ResponseModel> getData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.dashBoardUrl}";
    debugPrint('come here: $url');
    ResponseModel model =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }
}
