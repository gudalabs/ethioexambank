import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';

class QuizContestRepo {
  ApiClient apiClient;
  QuizContestRepo({required this.apiClient});

  Future<ResponseModel> quizListData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.contest}";
    debugPrint('come here: $url');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

   Future<ResponseModel> getExamQuestionList(String quizInfoID) async {

    // final map = {'quizInfo_id': quizInfo_ID,'exam_key': exam_key};

    String url = '${UrlContainer.baseUrl}${UrlContainer.quizContestQuestionsUrl +quizInfoID}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return responseModel;
  }


   Future<ResponseModel> submitAnswer(Map<String, dynamic> map) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.quizContestsubmitAnswerUrl}';
    debugPrint(url.toString());

    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    debugPrint(model.responseJson.toLowerCase());


    return model;
  }

}
