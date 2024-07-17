import 'dart:convert';
import 'package:quiz_lab/data/model/coin_store/coin_store_model.dart';
import 'package:quiz_lab/data/repo/coin_store/coin_store_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class CoinStoreController extends GetxController {
  CoinStoreRepo coinStoreRepo;

  CoinStoreController({required this.coinStoreRepo});

  String rank = "";

  List<CoinPlan> coinPlanList = [];

  bool isLoading = false;
  bool isActive = false;
  String currency = '';

  void getData() async {

    currency = coinStoreRepo.apiClient.getCurrencyOrUsername();

    isLoading = true;
    update();

    ResponseModel model = await coinStoreRepo.coinStoreData();

    coinPlanList.clear();

    if (model.statusCode == 200) {
      CoinStoreModel coinPlanModel = CoinStoreModel.fromJson(jsonDecode(model.responseJson));

      if (coinPlanModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<CoinPlan>? tempCoinPlanList = coinPlanModel.data?.coinPlans;

        if (tempCoinPlanList != null && tempCoinPlanList.isNotEmpty) {
          coinPlanList.addAll(tempCoinPlanList);
        }

      } else {
        CustomSnackBar.error(errorList: [...coinPlanModel.message!.error!]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isLoading = false;
    update();
  }

}
