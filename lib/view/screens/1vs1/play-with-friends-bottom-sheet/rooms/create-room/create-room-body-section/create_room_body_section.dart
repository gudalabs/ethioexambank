import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../core/utils/my_images.dart';
import '../../../../../../../core/utils/my_strings.dart';
import '../../../../../../../core/utils/style.dart';
import '../../../../../../../data/controller/battle/battle_room_controller.dart';
import '../../../../../../../data/model/battle/battle_category_list.dart';
import '../../../../../../../data/repo/battle/battle_repo.dart';
import '../../../../../../../data/services/api_client.dart';
import '../../../../../../components/buttons/rounded_loading_button.dart';
import '../../../../../../components/category-card/custom_room_card.dart';
import '../../../../../../components/text-form-field/custom_drop_down_field.dart';
import 'lobby_room_bottom_sheet.dart';

class CreateRoomBodySection extends StatefulWidget {
  const CreateRoomBodySection({super.key});

  @override
  State<CreateRoomBodySection> createState() => _CreateRoomBodySectionState();
}

class _CreateRoomBodySectionState extends State<CreateRoomBodySection> {
  List<int> coinValues = [5, 10, 15, 20]; // Coin values as integers

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BattleRepo(apiClient: Get.find()));
    Get.put(BattleRoomController(Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleRoomController>(initState: (state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        state.controller!.setCategoryData();
      });
    }, builder: (battleRoomController) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.space20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                MyStrings.selectCategory.tr,
                style: semiBoldMediumLarge,
              ),
              const SizedBox(height: Dimensions.space15),
              CustomDropDownTextField3(
                fillColor: MyColor.colorWhite,
                focusColor: MyColor.colorWhite,
                dropDownColor: MyColor.colorWhite,
                needLabel: false,
                selectedValue: null,
                onChanged: (value) {
                  var valueData = value as BattleCategory;

                  battleRoomController.slectACategory(valueData.id);
                },
                items: battleRoomController.categoryList.map<DropdownMenuItem<BattleCategory>>((BattleCategory value) {
                  return DropdownMenuItem<BattleCategory>(
                    value: value,
                    child: Text(
                      value.name,
                      style: const TextStyle(
                        fontSize: Dimensions.fontDefault,
                      ),
                    ),
                  );
                }).toList(),
                hintText: MyStrings.selectACategoryText.tr,
              ),
              const SizedBox(height: Dimensions.space25),
              Container(
                  padding: const EdgeInsets.all(Dimensions.space15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.space10),
                    color: MyColor.colorWhite,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                        padding: const EdgeInsetsDirectional.only(top: Dimensions.space15, start: Dimensions.space15),
                        child: Text(
                          MyStrings.entryCoinsForBattele.tr,
                          style: semiBoldMediumLarge, 
                        ),
                      ),  const SizedBox(height: Dimensions.space25),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: .79, crossAxisCount: 4),
                        itemCount: coinValues.length, // Use coinValues.length
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            onTap: () {
                              battleRoomController.setEntryFeeCustomRoom(coinValues[index].toString());
                            },
                            child: CustomCreateRoomCoinCard(
                              title: coinValues[index].toString(),
                              image: MyImages.coin,
                              selected: battleRoomController.entryFeeCustomRoom.toString() == coinValues[index].toString() ? true : false,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.space25),
                      SizedBox(
                        height: Dimensions.space47,
                        child: TextField(
                          controller: _textEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: MyStrings.enterCoins.tr,
                            filled: true,
                            fillColor: MyColor.cardColor,
                            labelStyle: regularExtraLarge.copyWith(color: MyColor.textColor),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (v) {
                            battleRoomController.setEntryFeeCustomRoom(v);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.space20,
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsetsDirectional.only(top: Dimensions.space30, start: Dimensions.space15),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      MyImages.coin,
                      fit: BoxFit.cover,
                      height: Dimensions.space47,
                    ),
                    const SizedBox(
                      width: Dimensions.space10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MyStrings.yourCoins.tr,
                          style: regularMediumLarge.copyWith(color: MyColor.textColor),
                        ),
                        const SizedBox(
                          height: Dimensions.space5,
                        ),
                         Text(
                          battleRoomController.battleRepo.apiClient.getUserCurrentCoin(),
                          style: semiBoldOverLarge,
                        )
                      ],
                    ),
                    const Spacer(),
                  
                  ],
                ),
              ),
              Obx(() {
                if (battleRoomController.roomCreateState.value == RoomCreateState.roomCreated) {
                  // Navigator.pop(context);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // Navigator.pop(context);

                    CustomBottomSheet(
                      enableDrag: false,
                      child: const LobbyBottomSheet(),
                    ).customBottomSheet(context);

                    battleRoomController.toogleBattleCreatedState(RoomCreateState.none);
                  });
                }

                return Padding(
                  padding: const EdgeInsetsDirectional.only(top: Dimensions.space40),
                  child: battleRoomController.roomCreateState.value == RoomCreateState.creatingRoom
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                          text: MyStrings.createRoom,
                          press: () {
                          
                            if (battleRoomController.slectedCategoryID.value == 0) {
                              CustomSnackBar.error(errorList: [MyStrings.selectACategoryText.tr]);
                            } else if (battleRoomController.entryFeeCustomRoom.value == "0") {
                              CustomSnackBar.error(errorList: [MyStrings.selectEntryCoinText.tr]);
                            } else {
                              battleRoomController.createNewRoom(
                                  categoryId: "${battleRoomController.slectedCategoryID.value}",
                                  entryFee: int.parse(battleRoomController.entryFeeCustomRoom.value),
                                  name: battleRoomController.battleRepo.apiClient.getUserFullName(),
                                  profileUrl: battleRoomController.battleRepo.apiClient.getUserImagePath(),
                                  uid: battleRoomController.battleRepo.apiClient.getUserID(),
                                  shouldGenerateRoomCode: true,
                                  questionList: []);
                            }

                            // debugPrint("${battleRoomController.roomCreateState.value}");
                          },
                          textSize: Dimensions.space20),
                );
              })
            ],
          ),
        ),
      );
    });
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const Text("Sheet");
      },
    );
  }
}
