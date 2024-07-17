import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/all_categories/all_categories_controller.dart';
import 'package:quiz_lab/view/components/animated_widget/expanded_widget.dart';
import 'package:quiz_lab/view/components/divider/custom_horizontal_divider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AllCategoriesExpandedSection extends StatelessWidget {
  final int categoryindex;
  final bool isExpand;
  final String title;
  final AllCategoriesController? controller;
  const AllCategoriesExpandedSection({super.key, required this.categoryindex, required this.isExpand, required this.title, this.controller});

  @override
  Widget build(BuildContext context) {
    return ExpandedSection(
      duration: 300,
      expand: isExpand,
      child: Column(
        children: [
          const CustomHorizontalDivider(),
          Container(
            color: MyColor.colorWhite,
            padding: const EdgeInsets.all(Dimensions.space10),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: context.width > 600 ? 3 : 2.3, crossAxisCount: 3),
                itemCount: controller!.allCategoriesList[categoryindex].quizInfos?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space5),
                      child: InkWell(
                        onTap: () {
                          if (controller!.allCategoriesList[categoryindex].quizInfos![index].levelStatus == MyStrings.unlock) {
                            Get.toNamed(RouteHelper.quizQuestionsScreen, arguments: [title, controller!.allCategoriesList[categoryindex].quizInfos![index].id]);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8, vertical: Dimensions.space8),
                          decoration: BoxDecoration(
                              color: controller!.allCategoriesList[categoryindex].quizInfos![index].levelStatus == MyStrings.lock
                                  ? MyColor.lockedLevel
                                  : controller!.allCategoriesList[categoryindex].quizInfos![index].playInfo != null
                                      ? MyColor.completedlevel
                                      : MyColor.unlockedLevel,
                              borderRadius: BorderRadius.circular(Dimensions.space7),
                              border: Border.all(color: controller!.allCategoriesList[categoryindex].quizInfos![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel)),
                          child: Row(
                            children: [
                              SvgPicture.asset(controller!.allCategoriesList[categoryindex].quizInfos![index].levelStatus == MyStrings.lock
                                  ? MyImages.lockLevelSVG
                                  : controller!.allCategoriesList[categoryindex].quizInfos![index].playInfo != null && controller!.allCategoriesList[categoryindex].quizInfos![index].playInfo?.isWin == '1'
                                      ? MyImages.levelGreenTikSVG
                                      : MyImages.unlockSVG),
                              const SizedBox(width: Dimensions.space8),
                              Expanded(
                                child: Text(
                                  controller!.allCategoriesList[categoryindex].quizInfos![index].level!.title.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: regularLarge.copyWith(
                                    color: controller!.allCategoriesList[categoryindex].quizInfos![index].levelStatus == MyStrings.lock
                                        ? MyColor.textColor
                                        : controller!.allCategoriesList[categoryindex].quizInfos![index].playInfo != null && controller!.allCategoriesList[categoryindex].quizInfos![index].playInfo?.isWin == '1'
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
    );
  }
}
