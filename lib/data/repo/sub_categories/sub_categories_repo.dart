import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';

class SubCategoriesRepo {
  ApiClient apiClient;
  SubCategoriesRepo({required this.apiClient});

  Future<ResponseModel> getData(String subcategoryId) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.subcategoriesUrl+subcategoryId}";
    debugPrint('all categories=====>: $subcategoryId');
    ResponseModel model =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }
}
