import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/chips/custom_chips_widget.dart';
import 'package:quiz_lab/view/components/image_widget/my_image_widget.dart';
import 'package:quiz_lab/view/screens/all-categories/widgets/all_categories_level_section.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/style.dart';

class CategoriesCard extends StatefulWidget {
  final String title, questions, image, imageMainPath, levels, minute, marks, date, subCategoryId;
  final bool expansionVisible, fromViewAll, fromExam, fromFunNlearn, fromAllCategory;
  final bool isExpand;
  final bool showLevel;
  final int index;
  final VoidCallback? onTap;

  const CategoriesCard(
      {super.key,
      required this.title,
      this.showLevel = true,
      this.questions = "",
      this.image = "",
      this.subCategoryId = "",
      this.expansionVisible = false,
      this.fromFunNlearn = false,
      this.fromAllCategory = false,
      required this.fromViewAll,
      this.levels = "1",
      this.fromExam = false,
      this.minute = "",
      this.marks = "",
      this.isExpand = false,
      required this.index,
      this.date = "",
      this.onTap,
      this.imageMainPath = ""});
  @override
  State<CategoriesCard> createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space8),
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
              onTap: widget.onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimensions.space3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: Dimensions.space20),
                      if (widget.imageMainPath == "null")
                        const SizedBox.shrink()
                      else
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: Dimensions.space14, top: Dimensions.space10),
                          width: Dimensions.space50,
                          height: Dimensions.space50,
                          child: MyImageWidget(
                            imageUrl: widget.image,
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: Dimensions.space15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title, style: semiBoldMediumLarge),
                              const SizedBox(height: Dimensions.space12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  widget.fromViewAll == false && widget.showLevel == true
                                      ? CustomChipsWidget(
                                          padding: Dimensions.space5,
                                          child: Center(child: Text(widget.fromExam ? widget.marks : widget.levels, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                        )
                                      : const SizedBox(),
                                  CustomChipsWidget(
                                    padding: Dimensions.space5,
                                    child: Center(child: Text(widget.fromExam ? widget.date : widget.questions + (widget.fromFunNlearn == true ? " ${MyStrings.quiz.tr}" : " ${MyStrings.questionse.tr}"), style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                  ),
                                  const SizedBox(width: Dimensions.space10),
                                  widget.fromExam
                                      ? CustomChipsWidget(
                                          padding: Dimensions.space5,
                                          child: Center(child: Text(widget.fromExam ? widget.minute : widget.questions, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      widget.fromExam
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsetsDirectional.only(top: Dimensions.space20),
                              child: SvgPicture.asset(widget.isExpand ? MyImages.arrowDownSVG : MyImages.playSVG, height: Dimensions.space35),
                            ),
                      const SizedBox(width: Dimensions.space20),
                    ],
                  ),
                  SizedBox(height: widget.expansionVisible ? Dimensions.space3 : Dimensions.space10),
                  widget.fromViewAll
                      ? AllCategoriesExpandedSection(
                          categoryindex: widget.index,
                          isExpand: widget.isExpand,
                          title: widget.title,
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: Dimensions.space5,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
