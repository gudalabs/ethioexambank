import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/all_categories/all_categories_controller.dart';
import 'package:quiz_lab/data/model/all_cartegories/all_categories_model.dart';
import 'package:quiz_lab/view/components/chips/custom_chips_widget.dart';
import 'package:quiz_lab/view/components/image_widget/my_image_widget.dart';
import 'package:quiz_lab/view/screens/all-categories/widgets/all_categories_level_section.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/style.dart';
import '../../../components/divider/custom_horizontal_divider.dart';

class AllCategoryListTileCardWidget extends StatefulWidget {
  final String title, image, subCategoryId;
  final bool fromViewAll;
  final bool isExpand;
  final bool showLevel;
  final int index;
  final Category categoryData;
  final VoidCallback? onTap;
  final AllCategoriesController? controller;
  const AllCategoryListTileCardWidget({super.key, required this.title, this.showLevel = true, this.image = "", this.subCategoryId = "", required this.fromViewAll, this.isExpand = false, required this.index, this.onTap, required this.categoryData, required this.controller});
  @override
  State<AllCategoryListTileCardWidget> createState() => _AllCategoryListTileCardWidgetState();
}

class _AllCategoryListTileCardWidgetState extends State<AllCategoryListTileCardWidget> {
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
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: Dimensions.space14, top: Dimensions.space10),
                        width: Dimensions.space50,
                        height: Dimensions.space50,
                        child: MyImageWidget(
                          imageUrl: widget.image,
                        ),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: Dimensions.space15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title, style: semiBoldMediumLarge),
                              const SizedBox(height: Dimensions.space15),
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (widget.categoryData.subcategoriesCount == "0") ...[
                                      CustomChipsWidget(
                                        padding: Dimensions.space5,
                                        right: Dimensions.space5,
                                        child: Center(child: Text("${widget.categoryData.questionsCount} ${MyStrings.questionse.tr}", style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                      ),
                                    ] else ...[
                                      CustomChipsWidget(
                                        padding: Dimensions.space5,
                                        right: Dimensions.space5,
                                        child: Center(child: Text("${widget.categoryData.subcategoriesCount} ${MyStrings.subcategory.tr}", style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: Dimensions.space20),
                        child: SvgPicture.asset(widget.isExpand ? MyImages.arrowDownSVG : MyImages.playSVG, height: Dimensions.space35),
                      ),
                      const SizedBox(width: Dimensions.space20),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.space10,
                  ),
                  if (widget.isExpand)
                    const CustomHorizontalDivider(
                      height: 0.3,
                    ),
                  widget.fromViewAll
                      ? AllCategoriesExpandedSection(
                          controller: widget.controller!,
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
