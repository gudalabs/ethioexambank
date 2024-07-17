import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../data/model/dashboard/exam.dart';
import '../../../../data/model/exam_zone/exam_zone_question_list_model.dart';
import '../../../components/chips/custom_chips_widget.dart';
import '../../../components/image_widget/my_image_widget.dart';

class ExamListTileCard extends StatefulWidget {
  final String title, image, minute, marks, date;

  final int index;
  final Exams exam;
  final VoidCallback? onTap;

  const ExamListTileCard({
    super.key,
    required this.title,
    this.image = "",
    this.minute = "",
    this.marks = "",
    required this.index,
    this.date = "",
    this.onTap,
    required this.exam,
  });
  @override
  State<ExamListTileCard> createState() => _ExamListTileCardState();
}

class _ExamListTileCardState extends State<ExamListTileCard> {
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
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.space10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: Dimensions.space10),

                      //Image
                      if (widget.image.toString() == "null") ...[
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
                            imageUrl: UrlContainer.examZoneImage + widget.image.toString(),
                          ),
                        ),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Title here
                            Text(widget.exam.title!.tr, style: semiBoldMediumLarge),

                            const SizedBox(height: Dimensions.space15),
                            //Title here
                            Text("${MyStrings.youNeedtoScoreLong.replaceAll("{point}", widget.exam.winningMark.toString()).tr} ", style: regularSmall),

                            const SizedBox(height: Dimensions.space15),
                            // //Title here
                            //Title here
                            Text("${MyStrings.entryFee.tr} - ${widget.exam.point.toString().tr} ${int.parse(widget.exam.point.toString()) > 1 ? MyStrings.coins.tr : MyStrings.coin.tr}", style: regularSmall),

                            const SizedBox(height: Dimensions.space15),
                            //Chips Here

                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomChipsWidget(
                                        right: Dimensions.space10,
                                        padding: Dimensions.space5,
                                        child: Center(
                                          child: Text(
                                            widget.marks,
                                            style: regularDefault.copyWith(color: MyColor.colorGrey),
                                          ),
                                        ),
                                      ),
                                      CustomChipsWidget(
                                        // top: Dimensions.space10,
                                        right: Dimensions.space10,
                                        padding: Dimensions.space5,
                                        child: Center(
                                          child: Text(
                                            widget.date,
                                            style: regularDefault.copyWith(color: MyColor.colorGrey),
                                          ),
                                        ),
                                      ),
                                      CustomChipsWidget(
                                        right: Dimensions.space10,
                                        padding: Dimensions.space5,
                                        child: Center(
                                          child: Text(
                                            widget.minute,
                                            style: regularDefault.copyWith(color: MyColor.colorGrey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
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
