import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/string_format_helper.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/core/utils/util.dart';
import 'package:quiz_lab/data/controller/coin_store/coin_store_controller.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/divider/custom_vertical_divider.dart';
import 'package:quiz_lab/view/components/image_widget/my_image_widget.dart';
import 'package:quiz_lab/view/components/no_data.dart';
import 'package:quiz_lab/view/screens/coin_store/deposit_widget/deposit_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../data/repo/coin_store/coin_store_repo.dart';

class CoinStoreScreen extends StatefulWidget {
  const CoinStoreScreen({super.key});

  @override
  State<CoinStoreScreen> createState() => _CoinStoreScreenState();
}

class _CoinStoreScreenState extends State<CoinStoreScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(CoinStoreRepo(apiClient: Get.find()));

    CoinStoreController controller = Get.put(CoinStoreController(coinStoreRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(
        title: MyStrings.coinStore.tr,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 20),
              child: InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.coinHistoryScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(MyImages.coinStoreDrawer),
                      Text(
                        MyStrings.history.tr,
                        style: regularLarge.copyWith(
                          fontSize: Dimensions.fontMediumLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<CoinStoreController>(
        builder: (controller) => controller.isLoading == true
            ? const CustomLoader()
            : controller.coinPlanList.isEmpty
                ? const SingleChildScrollView(child: NoDataWidget())
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsetsDirectional.only(top: Dimensions.space40,bottom: Dimensions.space25),
                    shrinkWrap: true,
                    itemCount: controller.coinPlanList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space5),
                        child: InkWell(
                          onTap: () {
                            // CustomBottomSheet(child: const PaymentBottomSheetScreen())
                            //     .customBottomSheet(context);

                            Get.to(() => NewDepositScreen(
                                  price: controller.coinPlanList[index].price.toString(),
                                  id: controller.coinPlanList[index].id.toString(),
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(Dimensions.space8),
                            decoration: BoxDecoration(
                              color: MyColor.colorWhite,
                              borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                              boxShadow: MyUtils.getBottomSheetShadow()
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                        Dimensions.space10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          controller.coinPlanList[index].image != null? MyImageWidget(
                                              height: Dimensions.space30,
                                              width:  Dimensions.space30,
                                              fromCoin: true,
                                              boxFit: BoxFit.cover,
                                              imageUrl: "${UrlContainer.coinImages}${controller.coinPlanList[index].image}") :
                                          SvgPicture.asset(
                                            MyImages.coin,
                                            fit: BoxFit.cover,
                                            height: Dimensions.space30,
                                          ),
                                          const SizedBox(
                                            width: Dimensions.space10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  controller.coinPlanList[index].title?.tr ?? '',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: regularLarge.copyWith(color: MyColor.textColor),
                                                ),
                                                const SizedBox(
                                                  height: Dimensions.space5,
                                                ),
                                                Text(
                                                  Converter.roundDoubleAndRemoveTrailingZero(controller.coinPlanList[index].coinsAmount ?? '0').tr,
                                                  style: semiBoldMediumLarge.copyWith(fontWeight: FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: Dimensions.space10,
                                        ),
                                        const CustomVerticalDivider(
                                          height: Dimensions.space30,
                                        ),
                                        const SizedBox(
                                          width: Dimensions.space20,
                                        ),
                                        SizedBox(child: Text("${Converter.formatNumber(controller.coinPlanList[index].price ?? '00').tr} ${controller.currency.tr}", style: semiBoldExtraLarge))
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
      ),
    );
  }
}
