import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';

class BattleRepo {
  ApiClient apiClient;
  BattleRepo({required this.apiClient});

  Future<ResponseModel> getCategoryListData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.battleCategoryLIst}";
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

  Future<ResponseModel> getBatttleQuestion(int id, int user1ID, int user2ID) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.battleQuestionList}/${user1ID.toString()}/${user2ID.toString()}/${id.toString()}";
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return model;
  }

  Future<ResponseModel> finishBattleAndSubmitAnswer(Map<String, dynamic> map) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.battleAnswerSubmit}';
    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return model;
  }
}
