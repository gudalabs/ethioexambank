// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/view/components/animated_widget/expanded_widget.dart';
import 'package:quiz_lab/view/components/divider/custom_horizontal_divider.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/ads/admob_helper.dart';
import '../../../../../data/model/guess_the_word/guess_subcategory_model.dart';
import '../../../../components/chips/custom_chips_widget.dart';
import '../../../../components/image_widget/my_image_widget.dart';

class GuessWordSubCategoryCard extends StatefulWidget {
  final GuessSubCategory subcategory;
  final String image;

  const GuessWordSubCategoryCard({
    super.key,
    required this.subcategory,
    this.image = "",
  });
  @override
  State<GuessWordSubCategoryCard> createState() => _GuessWordSubCategoryCardState();
}

class _GuessWordSubCategoryCardState extends State<GuessWordSubCategoryCard> {
  AdmobHelper admobHelper = AdmobHelper();
  bool isExpande = false;
  int labelCount = 0;

  @override
  void initState() {
    // attention: generate list size here
    labelCount = widget.subcategory.quizInfos!.length > 3 ? 3 : widget.subcategory.quizInfos!.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space10),
      child: Container(
          decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: MyColor.cardShaddowColor2, width: 0.5),
            boxShadow: const [
              BoxShadow(
                color: MyColor.cardShaddowColor2,
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(5.0),
              onTap: () {
                admobHelper.showInterstitialAd();
                setState(() {
                  isExpande = !isExpande;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimensions.space3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: Dimensions.space20),
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: Dimensions.space20, bottom: Dimensions.space20),
                        width: Dimensions.space50,
                        height: Dimensions.space50,
                        child: MyImageWidget(
                          imageUrl: widget.image,
                        ),
                      ),
                      const SizedBox(width: Dimensions.space20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: Dimensions.space15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.subcategory.name.toString(), style: semiBoldMediumLarge),
                              const SizedBox(height: Dimensions.space12),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomChipsWidget(
                                      padding: Dimensions.space5,
                                      right: Dimensions.space10,
                                      child: Center(child: Text("${widget.subcategory.questionsCount} ${MyStrings.questionse.tr}", style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                    ),
                                    CustomChipsWidget(
                                      padding: Dimensions.space5,
                                      child: Center(child: Text("${widget.subcategory.quizInfos!.length} ${MyStrings.level.tr}", style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.space20,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: Dimensions.space20),
                        child: SvgPicture.asset(isExpande ? MyImages.arrowDownSVG : MyImages.playSVG, height: Dimensions.space35),
                      ),
                      const SizedBox(width: Dimensions.space20),
                    ],
                  ),
                  widget.subcategory.quizInfos != null
                      ? ExpandedSection(
                          duration: 300,
                          expand: isExpande,
                          child: Column(
                            children: [
                              const CustomHorizontalDivider(
                                height: 0.3,
                              ),
                              Container(
                                color: MyColor.colorWhite,
                                padding: const EdgeInsets.all(Dimensions.space10),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: context.width > 600 ? 3 : 2.3, crossAxisCount: 3),
                                    itemCount: widget.subcategory.quizInfos!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space5),
                                          child: InkWell(
                                            onTap: () {
                                              if (widget.subcategory.quizInfos![index].levelStatus == MyStrings.unlock) {
                                                Get.toNamed(
                                                  RouteHelper.guessTheword,
                                                  arguments: widget.subcategory.quizInfos![index].id,
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8, vertical: Dimensions.space8),
                                              decoration: BoxDecoration(
                                                  color: widget.subcategory.quizInfos![index].levelStatus == MyStrings.lock
                                                      ? MyColor.lockedLevel
                                                      : widget.subcategory.quizInfos![index].playInfo != null
                                                          ? MyColor.completedlevel
                                                          : MyColor.unlockedLevel,
                                                  borderRadius: BorderRadius.circular(Dimensions.space7),
                                                  border: Border.all(color: widget.subcategory.quizInfos![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel)),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(widget.subcategory.quizInfos![index].levelStatus == MyStrings.lock
                                                      ? MyImages.lockLevelSVG
                                                      : widget.subcategory.quizInfos![index].playInfo != null
                                                          ? MyImages.levelGreenTikSVG
                                                          : MyImages.unlockSVG),
                                                  const SizedBox(width: Dimensions.space8),
                                                  Expanded(
                                                    child: Text(
                                                      "${widget.subcategory.quizInfos![index].level!.title}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: regularLarge.copyWith(
                                                        color: widget.subcategory.quizInfos![index].levelStatus == MyStrings.lock
                                                            ? MyColor.textColor
                                                            : widget.subcategory.quizInfos![index].playInfo != null
                                                                ? MyColor.completedlevelTEXT
                                                                : MyColor.colorBlack,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    }),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          )),
    );
  }
}
