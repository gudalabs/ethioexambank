import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:quiz_lab/view/screens/exam_zone/widgets/enter_exam_room_bottom_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/url_container.dart';
import '../../../../../components/bottom-sheet/custom_bottom_sheet_plus.dart';
import '../../../../../components/chips/custom_chips_widget.dart';
import '../../../../../components/image_widget/my_image_widget.dart';

class ExamZoneSection extends StatefulWidget {
  const ExamZoneSection({super.key});

  @override
  State<ExamZoneSection> createState() => _ExamZoneSectionState();
}

class _ExamZoneSectionState extends State<ExamZoneSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: Dimensions.space5, start: Dimensions.space5, end: Dimensions.space5, top: Dimensions.space20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  MyStrings.examZone.tr,
                  style: semiBoldMediumLarge,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.examZoneScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.space5),
                    child: Text(
                      MyStrings.viewAll.tr,
                      style: semiBoldLarge.copyWith(color: MyColor.colorlighterGrey, fontSize: Dimensions.space15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Dimensions.space8,
          ),
          controller.examZonelist.isNotEmpty
            ? SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                  child: Row(
                    children: List.generate(controller.examZonelist.length, (index) {
                      var item = controller.examZonelist[index];
                      return SizedBox(
                        width: context.width * 0.85,
                        child: GestureDetector(
                          onTap: () async {
                            CustomBottomSheetPlus(
                              isScrollControlled: true,
                              enableDrag: true,
                              child: EnterRoomBottomSheetWidget(quizInfo: item),
                            ).customBottomSheet(context);

                            await controller.examZoneRepo.getExamCode(item.id.toString());
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsetsDirectional.only(top: Dimensions.space3),
                                  padding: const EdgeInsets.all(Dimensions.space12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //Image
                                      if (item.image.toString() == "null") ...[
                                        Container(
                                          margin: const EdgeInsetsDirectional.only(start: Dimensions.space10),
                                          child: SvgPicture.asset(
                                            MyImages.examzoneSVG,
                                            height: context.width * 0.15,
                                            width: context.width * 0.15,
                                          ),
                                        ),
                                      ] else ...[
                                        Container(
                                          margin: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                          child: MyImageWidget(
                                            height: context.width * 0.15,
                                            width: context.width * 0.15,
                                            imageUrl: UrlContainer.examZoneImage + item.image.toString(),
                                          ),
                                        ),
                                      ],
                                      //Contents
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              item.title.toString().tr,
                                              style: semiBoldMediumLarge,
                                              maxLines: 1,
                                            ),
                                            const SizedBox(height: Dimensions.space8),
                                            Text(
                                              "${item.description.toString().tr} ",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: regularDefault.copyWith(color: MyColor.textSecondColor),
                                            ),
                                            const SizedBox(height: Dimensions.space10),
                                            Text(
                                              "${MyStrings.examStartTime.tr} ${item.examStartTime.toString().tr}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: regularDefault.copyWith(
                                                fontSize: Dimensions.fontSmall,
                                                color: MyColor.colorlighterGrey,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: Dimensions.space3,
                                            ),
                                            Text(
                                              "${MyStrings.total.tr} ${item.examDuration.toString()} ${MyStrings.min.tr} ",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: regularDefault.copyWith(
                                                fontSize: Dimensions.fontSmall,
                                                color: MyColor.colorlighterGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: Dimensions.space12,
                                ),
                                Container(
                                  height: 0.1,
                                  color: MyColor.colorlighterGrey,
                                ),
                                const SizedBox(
                                  height: Dimensions.space12,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(Dimensions.space10),
                                  child: Row(
                                    children: [
                                      Flexible(child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                          child: Row(
                                            children: [
                                              CustomChipsWidget(
                                                right: Dimensions.space7,
                                                child: Center(
                                                  child: Text(
                                                    "${MyStrings.entryFee.tr} - ${item.point.toString().tr}",
                                                    style: regularSmall.copyWith(color: MyColor.colorGrey),
                                                  ),
                                                ),
                                              ),
                                              CustomChipsWidget(
                                                right: Dimensions.space7,
                                                child: Center(child: Text(MyStrings.youNeedtoScoreSort.replaceAll("{point}", item.point.toString()).tr, style: regularSmall.copyWith(color: MyColor.colorGrey))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ))
            : Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
                padding: const EdgeInsets.all(Dimensions.space20),
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
                child: Center(
                  child: Text(
                    MyStrings.noExamFound.tr,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: regularDefault.copyWith(color: MyColor.spinLoadColor),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
