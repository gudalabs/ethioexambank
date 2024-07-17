import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/date_converter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../data/model/exam_zone/completed_exam_zone_model.dart';
import '../../../components/chips/custom_chips_widget.dart';
import '../../../components/chips/custom_color_chips.dart';
import '../../../components/image_widget/my_image_widget.dart';

class CompletedExamListTileCard extends StatelessWidget {
  final String title, image;
  final CompletedExam exam;
  final int index;
  final VoidCallback? onTap;

  const CompletedExamListTileCard({
    super.key,
    required this.title,
    this.image = "",
    required this.index,
    this.onTap,
    required this.exam,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(Dimensions.space10),
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
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.space10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: Dimensions.space10),

                      //Image
                      if (image.toString() == "null") ...[
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                          child: SvgPicture.asset(
                            MyImages.examzoneSVG,
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                        ),
                      ] else ...[
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                          child: MyImageWidget(
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            imageUrl: UrlContainer.examZoneImage + image.toString(),
                          ),
                        ),
                      ],
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: Dimensions.space10, bottom: Dimensions.space10, end: Dimensions.space10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Title here
                              Text(title.tr, style: semiBoldMediumLarge),

                              const SizedBox(height: Dimensions.space15),
                              //Chips Here

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomChipsWidget(
                                        right: Dimensions.space10,
                                        padding: Dimensions.space5,
                                        child: Center(
                                          child: Text(
                                            DateConverter.estimatedDate(exam.startDate).tr,
                                            style: regularDefault.copyWith(color: MyColor.colorGrey),
                                          ),
                                        ),
                                      ),
                                      if (exam.playInfo.isWin == "1") ...[
                                        CustomColorChipsWidget(
                                          color: MyColor.colorGreen,
                                          right: Dimensions.space10,
                                          padding: Dimensions.space5,
                                          child: Text(
                                            MyStrings.win.tr,
                                            style: regularDefault.copyWith(color: MyColor.colorGreen),
                                          ),
                                        ),
                                      ] else ...[
                                        CustomColorChipsWidget(
                                          color: MyColor.colorRed,
                                          right: Dimensions.space10,
                                          padding: Dimensions.space5,
                                          child: Text(
                                            MyStrings.loss.tr,
                                            style: regularDefault.copyWith(color: MyColor.colorRed),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
