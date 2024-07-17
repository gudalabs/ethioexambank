import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/date_converter.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/core/utils/util.dart';
import 'package:quiz_lab/data/controller/coin_history/coin_history_controller.dart';
import 'package:quiz_lab/data/repo/coin_history/coin_history_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:get/get.dart';

import '../../components/custom_loader/custom_loader.dart';
import '../../components/no_data.dart';

class CoinHistoryScreen extends StatefulWidget {
  const CoinHistoryScreen({super.key});

  @override
  State<CoinHistoryScreen> createState() => _CoinHistoryScreenState();
}

class _CoinHistoryScreenState extends State<CoinHistoryScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(CoinHistoryRepo(apiClient: Get.find()));

    CoinHistoryController controller = Get.put(CoinHistoryController(coinHistoryRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinHistoryController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: MyStrings.coinHistory.tr,
        ),
        body: controller.isLoading == true
            ? const CustomLoader()
            : controller.coinHistoryList.isEmpty
                ? SingleChildScrollView(child: NoDataWidget(
          messages: MyStrings.noCoinHistoryFound.tr,
        ))
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsetsDirectional.only(top: Dimensions.space25,start: Dimensions.space15,end: Dimensions.space15),
                    // shrinkWrap: true,
                    itemCount: controller.coinHistoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final coinHistoryItem = controller.coinHistoryList[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: Dimensions.space12),
                          decoration: BoxDecoration(
                              color: MyColor.colorWhite,
                              borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                              boxShadow: MyUtils.getCardShadow()
                          ),
                          padding: const EdgeInsets.all(Dimensions.space6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(
                                  Dimensions.space7,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: Dimensions.space10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(coinHistoryItem.coinPlan!.title.toString().tr, style: semiBoldMediumLarge),
                                        const SizedBox(
                                          height: Dimensions.space8,
                                        ),
                                        Text(
                                          DateConverter.isoStringToLocalFormattedDateAndTimeOnly(controller.coinHistoryList[index].createdAt!.toIso8601String()).tr,
                                          style: regularLarge.copyWith(color: MyColor.textColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: Dimensions.space10,
                              ),
                              const Spacer(),
                              SizedBox(
                                  child: Text("${controller.coinHistoryRepo.apiClient.getCurrencyOrUsername(isCurrency: true,isSymbol: true)}${controller.coinHistoryList[index].coinPlan!.price} ${controller.coinHistoryRepo.apiClient.getCurrencyOrUsername(isCurrency: true,isSymbol: false)}",
                                      style: semiBoldLarge.copyWith(
                                          color: coinHistoryItem.status == "+"
                                              ? MyColor.colorGreen
                                              : coinHistoryItem.status == "-"
                                              ? MyColor.colorRed
                                              : Colors.black))),
                              const SizedBox(
                                width: Dimensions.space10,
                              ),
                            ],
                          )
                      );
                    }),
      ),
    );
  }
}
