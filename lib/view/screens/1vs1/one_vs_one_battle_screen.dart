import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/repo/battle/battle_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/bottom-sheet/custom_bottom_sheet_plus.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/divider/or_divider.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import '../../../data/controller/battle/one_vs_multi_controller.dart';
import '../../../data/model/battle/battle_category_list.dart';
import '../../components/text-form-field/custom_drop_down_field.dart';
import 'appbar-components/custom_sliver_delegate.dart';
import 'play-with-friends-bottom-sheet/play_with_friends_bottom_sheet.dart';

class OneVSOneBattleScreen extends StatefulWidget {
  final bool isGroupBattle;
  const OneVSOneBattleScreen({super.key, this.isGroupBattle = false});

  @override
  State<OneVSOneBattleScreen> createState() => _OneVSOneBattleScreenState();
}

class _OneVSOneBattleScreenState extends State<OneVSOneBattleScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OneVsMutiController>(
        init: OneVsMutiController(Get.put(BattleRepo(apiClient: Get.put(ApiClient(sharedPreferences: Get.find()))))),
        initState: (_) async {},
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: CustomSliverDelegates(
                      isGroupBattle: widget.isGroupBattle,
                      expandedHeight: Dimensions.space180,
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                      child: controller.isLoadingCategory.value == true
                          ? const CustomLoader()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  MyStrings.selectCategory.tr,
                                  style: semiBoldExtraLarge,
                                ),
                                const SizedBox(
                                  height: Dimensions.space20,
                                ),
                                CustomDropDownTextField3(
                                  fillColor: MyColor.colorWhite,
                                  focusColor: MyColor.colorWhite,
                                  dropDownColor: MyColor.colorWhite,
                                  needLabel: false,
                                  selectedValue: null,
                                  onChanged: (value) {
                                    var valueData = value as BattleCategory;

                                    controller.selectACategory(valueData.id);
                                  },
                                  items: controller.categoryList.map<DropdownMenuItem<BattleCategory>>((BattleCategory value) {
                                    return DropdownMenuItem<BattleCategory>(
                                      value: value,
                                      child: Text(
                                        value.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: Dimensions.fontDefault,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hintText: MyStrings.selectACategoryText.tr,
                                ),
                                const SizedBox(
                                  height: Dimensions.space40,
                                ),
                                RoundedButton(
                                    text: widget.isGroupBattle ? MyStrings.groupBattle.tr : MyStrings.letsPlay.tr,
                                    press: () async {
                                      if (controller.selectedCategoryID.value == 0) {
                                        CustomSnackBar.error(errorList: [MyStrings.selectACategoryMsg.tr]);
                                      } else if (int.parse(controller.battleRepo.apiClient.getUserCurrentCoin()) < int.parse(controller.entryFeeRandomGame.value)) {
                                        CustomSnackBar.error(errorList: [MyStrings.youHaveNoCoins.tr]);
                                      } else {
                                        Get.toNamed(RouteHelper.findOpponentScreen, arguments: [controller.selectedCategoryID.value, controller.entryFeeRandomGame.value, <BattleCategory>[]]); //Send Question List and ID to next page
                                      }
                                    },
                                    textSize: Dimensions.space20,
                                    cornerRadius: Dimensions.space10),
                                const SizedBox(
                                  height: Dimensions.space20,
                                ),
                                const OrDivider(),
                                const SizedBox(
                                  height: Dimensions.space25,
                                ),
                                RoundedButton(
                                    text: MyStrings.playWithFriend.tr,
                                    press: () {
                                      if (controller.categoryList.isEmpty) {
                                        CustomSnackBar.error(errorList: [MyStrings.noCategoryFound]);
                                      } else {
                                        CustomBottomSheetPlus(child: const PlayWithFriendsBottomSheetWidget()).customBottomSheet(context);
                                      }
                                    },
                                    textSize: Dimensions.space20,
                                    color: MyColor.colorBlack,
                                    cornerRadius: Dimensions.space10),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
