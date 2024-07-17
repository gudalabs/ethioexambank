import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/data/model/leaderBoard/leaderBoard_model.dart';
import 'package:quiz_lab/data/repo/leaderBoard/leader_board_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class LeaderBoardController extends GetxController {
  LeaderBoardRepo leaderBoardRepo;

  LeaderBoardController({required this.leaderBoardRepo});

  List<User> leaderBoardlist = [];

  String rank1PlayerName = "";
  String rank2PlayerName = "";
  String rank3PlayerName = "";
  String rank1PlayerScore = "00";
  String rank2PlayerScore = "00";
  String rank3PlayerScore = "00";
  String rank1PlayerAvatar = "";
  String rank2PlayerAvatar = "";
  String rank3PlayerAvatar = "";

  bool isLoading = true;

  bool isActive = false;

  void getData() async {
    isLoading = true;
    update();

    ResponseModel model = await leaderBoardRepo.getLeaderBoardData();

    if (model.statusCode == 200) {
      leaderBoardlist.clear();

      LeaderBoardModel leaderBoardModel = LeaderBoardModel.fromJson(jsonDecode(model.responseJson));

      if (leaderBoardModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<User>? leaderBoardList = leaderBoardModel.data?.user;

        if (leaderBoardList != null && leaderBoardList.isNotEmpty) {
          leaderBoardlist.addAll(leaderBoardList);
        }

        for (int i = 0; i < leaderBoardlist.length && i < 3; i++) {
          switch (i) {
            case 0:
              rank1PlayerName = leaderBoardList?[i].fullName ?? leaderBoardList?[i].username.toString() ?? '';
              rank1PlayerScore = leaderBoardList?[i].score ?? '0';
              rank1PlayerAvatar = leaderBoardList?[i].avatar ?? '';
              break;
            case 1:
              rank2PlayerName = leaderBoardList?[i].fullName ?? leaderBoardList?[i].username.toString() ?? '';
              rank2PlayerScore = leaderBoardList?[i].score ?? '0';
              rank2PlayerAvatar = leaderBoardList?[i].avatar ?? '';
              break;
            case 2:
              rank3PlayerName = leaderBoardList?[i].fullName ?? leaderBoardList?[i].username.toString() ?? '';
              rank3PlayerScore = leaderBoardList?[i].score ?? '0';
              rank3PlayerAvatar = leaderBoardList?[i].avatar ?? '';
              break;
            default:
              break;
          }
        }
      } else {
        CustomSnackBar.error(errorList: [...leaderBoardModel.message!.error!]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    debugPrint('---------------------${model.statusCode}');

    isLoading = false;
    update();
  }
}
