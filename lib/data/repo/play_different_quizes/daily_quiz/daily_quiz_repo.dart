import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';



class DailyQuizRepo {
  ApiClient apiClient;
  DailyQuizRepo({required this.apiClient});

 Future<ResponseModel> getDailyQuestions() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.dailyQuizQuestionsUrl }";
    debugPrint('come here: $url');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }
     Future<ResponseModel> submitAnswer(Map<String, dynamic> map) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.dailyQuizSubmitAnswerUrl}';
    debugPrint(url.toString());

    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    debugPrint(model.responseJson.toLowerCase());


    return model;
  }
}
