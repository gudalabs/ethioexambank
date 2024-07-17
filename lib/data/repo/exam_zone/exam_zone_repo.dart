import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';

class ExamZoneRepo {
  ApiClient apiClient;
  ExamZoneRepo({required this.apiClient});

  Future<ResponseModel> examZoneData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.examZone}";
    debugPrint('come here: $url');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

  Future<ResponseModel> completedExamListData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.examCompletedList}";
    debugPrint('come here: $url');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

  Future<ResponseModel> getExamQuestionList(String quizInfoID, examkey) async {
    final map = {'quizInfo_id': quizInfoID, 'exam_key': examkey};

    String url = '${UrlContainer.baseUrl}${UrlContainer.examZoneQuestionsUrl}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    return responseModel;
  }

  Future<ResponseModel> getExamDetails(String quizID) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.examDetails}/$quizID';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return responseModel;
  }

  Future<ResponseModel> getExamCode(String quizID) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.examCode}/$quizID';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return responseModel;
  }

  Future<ResponseModel> submitAnswer(Map<String, dynamic> map) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.examsubmitAnswerUrl}';
    debugPrint(url.toString());

    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    debugPrint(model.responseJson.toLowerCase());


    return model;
  }
}
