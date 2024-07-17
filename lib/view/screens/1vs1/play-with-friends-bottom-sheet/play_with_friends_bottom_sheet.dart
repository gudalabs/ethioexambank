import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';

import '../../../../data/controller/battle/one_vs_multi_controller.dart';
import '../../../../data/model/battle/battle_category_list.dart';

class PlayWithFriendsBottomSheetWidget extends StatelessWidget {
  const PlayWithFriendsBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OneVsMutiController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(top: Dimensions.space10, start: Dimensions.space15, end: Dimensions.space15),
        child: Column(
          children: [
            const BottomSheetBar(),
            const SizedBox(height: Dimensions.space20),
            RoundedButton(
              text: MyStrings.createRoom.tr,
              press: () {
                Get.back();
                Get.toNamed(RouteHelper.createRoomScreen, arguments: [null, null, controller.categoryList.isNotEmpty ? controller.categoryList : <BattleCategory>[]]);
              },
              textSize: Dimensions.space20,
              cornerRadius: Dimensions.space10,
            ),
            const SizedBox(
              height: Dimensions.space20,
            ),
            RoundedButton(
              text: MyStrings.joinRoom.tr,
              press: () {
                Get.back();
                Get.toNamed(RouteHelper.joinRoomScreen, arguments: [null, null, controller.categoryList.isNotEmpty ? controller.categoryList : <BattleCategory>[]]);
              },
              color: MyColor.colorBlack,
              textSize: Dimensions.space20,
              cornerRadius: Dimensions.space10,
            ),
            const SizedBox(
              height: Dimensions.space50,
            ),
          ],
        ),
      );
    });
  }
}
