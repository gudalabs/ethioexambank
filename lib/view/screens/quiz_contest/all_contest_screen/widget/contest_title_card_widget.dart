import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/date_converter.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../core/utils/url_container.dart';
import '../../../../../data/model/quiz_contest/quiz_contest_list_model.dart';
import '../../../../components/chips/custom_chips_widget.dart';
import '../../../../components/image_widget/my_image_widget.dart';

class ContestListTileCard extends StatefulWidget {
  final String image;

  final int index;
  final Contest contest;
  final VoidCallback? onTap;

  const ContestListTileCard({
    super.key,
    this.image = "",
    required this.index,
    this.onTap,
    required this.contest,
  });
  @override
  State<ContestListTileCard> createState() => _ContestListTileCardState();
}

class _ContestListTileCardState extends State<ContestListTileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left:Dimensions.space10,right:Dimensions.space10,bottom:Dimensions.space10),
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
                            imageUrl: UrlContainer.quizContestImage + widget.image.toString(),
                          ),
                        ),
                      ],
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only( bottom: Dimensions.space10, end: Dimensions.space10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Title here
                              Text(widget.contest.title!.tr, style: semiBoldMediumLarge),

                              const SizedBox(height: Dimensions.space15),
                              //Title here
                              Text("${MyStrings.youNeedtoScoreLong.replaceAll("{point}", widget.contest.winningMark.toString()).tr} ", style: regularSmall),

                              const SizedBox(height: Dimensions.space15),
                              // //Title here
                              //Title here
                              Text("${MyStrings.entryFee.tr} - ${widget.contest.point.toString().tr} ${int.parse(widget.contest.point.toString()) > 1 ? MyStrings.coins.tr : MyStrings.coin.tr}", style: regularSmall),

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
                                          right: Dimensions.space7,
                                          child: Center(
                                              child: Text(
                                            "${MyStrings.entryFee.tr} - ${widget.contest.point}",
                                            style: regularDefault.copyWith(color: MyColor.colorGrey),
                                          )),
                                        ),
                                        CustomChipsWidget(
                                          right: Dimensions.space7,
                                          child: Center(
                                            child: Text(
                                              '${MyStrings.end.tr} ${DateConverter.stringDateToDate(widget.contest.endDate.toString())}',
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
