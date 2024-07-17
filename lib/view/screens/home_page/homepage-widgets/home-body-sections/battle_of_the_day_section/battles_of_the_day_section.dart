import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/view/screens/1vs1/one_vs_one_battle_screen.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_strings.dart';
import '../../../../../../core/utils/style.dart';

class BattleOfTheDaySection extends StatefulWidget {
  const BattleOfTheDaySection({
    super.key,
  });

  @override
  State<BattleOfTheDaySection> createState() => _BattleOfTheDaySectionState();
}

class _BattleOfTheDaySectionState extends State<BattleOfTheDaySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: Dimensions.space5, start: Dimensions.space5, end: Dimensions.space4, top: Dimensions.space20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                MyStrings.battleOfTheDay.tr,
                style: semiBoldMediumLarge,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Dimensions.space10,
        ),
        InkWell(
          onTap: () {
            Get.to(() => const OneVSOneBattleScreen());
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
            decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.space10),
              boxShadow: const [
                BoxShadow(
                  color: MyColor.cardShaddowColor2,
                  offset: Offset(0, 8),
                  blurRadius: 60,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.space15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: Dimensions.space50,
                          width: Dimensions.space220,
                          padding: const EdgeInsetsDirectional.only(top: Dimensions.space7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                MyStrings.oneVSone.tr,
                                style: semiBoldMediumLarge,
                              ),
                              const SizedBox(height: Dimensions.space8),
                              Text(
                                MyStrings.battleQuiz.tr,
                                style: regularDefault.copyWith(color: MyColor.colorlighterGrey),
                              )
                            ],
                          ),
                        ),
                      ),
                      // const Spacer(),
                      Image.asset(
                        MyImages.battleKnife,
                        height: context.width * 0.18,
                      ),
                      const SizedBox(
                        width: Dimensions.space10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Dimensions.space10,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: Dimensions.space15,
        ),
      ],
    );
  }
}
