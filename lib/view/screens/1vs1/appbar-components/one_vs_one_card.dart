import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/view/components/divider/custom_divider.dart';
import 'package:get/get.dart';
import '../../../../data/controller/battle/one_vs_multi_controller.dart';
import '../../../components/divider/custom_vertical_divider.dart';

class OneVSOneCustomCardWidget extends StatefulWidget {
  const OneVSOneCustomCardWidget({super.key});

  @override
  State<OneVSOneCustomCardWidget> createState() => _OneVSOneCustomCardWidgetState();
}

class _OneVSOneCustomCardWidgetState extends State<OneVSOneCustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OneVsMutiController>(builder: (controller) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.space10)),
        elevation: .5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SizedBox(
                height: Dimensions.space50,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space5, start: Dimensions.space10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              MyStrings.entryFees.tr,
                              style: regularMediumLarge.copyWith(color: MyColor.battleTextColor),
                            ),
                            const CustomDivider(
                              space: Dimensions.space3,
                            ),
                            Text("${controller.entryFeeRandomGame.value} ${MyStrings.coins.tr}", maxLines: 1, overflow: TextOverflow.ellipsis, style: semiBoldExtraLarge)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const CustomVerticalDivider(
              height: Dimensions.space25,
            ),
            Expanded(
              child: SizedBox(
                height: Dimensions.space50,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space5, start: Dimensions.space5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: Dimensions.space8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              MyStrings.currentCoin,
                              style: regularMediumLarge.copyWith(color: MyColor.battleTextColor),
                            ),
                            const CustomDivider(
                              space: Dimensions.space3,
                            ),
                            Text("${controller.battleRepo.apiClient.getUserCurrentCoin()} ${MyStrings.coins}", maxLines: 1, overflow: TextOverflow.ellipsis, style: semiBoldExtraLarge),
                            const SizedBox(
                              width: Dimensions.space8,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
