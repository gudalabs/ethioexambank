import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../../core/helper/date_converter.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_strings.dart';
import '../../../../../../core/utils/style.dart';
import '../../../../../components/chips/custom_chips_widget.dart';
import '../../../../../components/image_widget/my_image_widget.dart';

class QuizContestSection extends StatefulWidget {
  const QuizContestSection({super.key});

  @override
  State<QuizContestSection> createState() => _QuizContestSectionState();
}

class _QuizContestSectionState extends State<QuizContestSection> {
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
                  MyStrings.quizContest.tr,
                  style: semiBoldMediumLarge,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.quizContestListscreen);
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
            height: Dimensions.space10,
          ),
          controller.contestlist.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: IntrinsicHeight(
                      child: Row(
                        children: List.generate(
                        controller.contestlist.length,
                        (index) => SizedBox(
                          width: context.width * 0.85,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.quizContestQuestionscreen, arguments: [
                              controller.contestlist[index].id.toString(),
                              controller.contestlist[index].title.toString(),
                              null,
                              null,
                              ]);
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
                                        if (controller.contestlist[index].image.toString() == "null") ...[
                                          Container(
                                            margin: const EdgeInsetsDirectional.only(end: Dimensions.space10),
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
                                              imageUrl: UrlContainer.quizContestImage + controller.contestlist[index].image.toString(),
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
                                                controller.contestlist[index].title.toString().tr,
                                                style: semiBoldMediumLarge,
                                                maxLines: 1,
                                              ),
                                              const SizedBox(height: Dimensions.space8),
                                              Text(
                                                "${controller.contestlist[index].description.toString().tr} ",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: regularDefault.copyWith(color: MyColor.colorlighterGrey),
                                              )
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
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                 "${MyStrings.entryFee.tr} - ${controller.contestlist[index].point?.tr}",
                                                 style: regularSmall.copyWith(color: MyColor.colorGrey),
                                                 )
                                               ),
                                             ),
                                             CustomChipsWidget(
                                               right: Dimensions.space7,
                                               child: Center(
                                                 child: Text(
                                                   '${MyStrings.end.tr} ${DateConverter.stringDateToDate(controller.contestlist[index].endDate.toString()).tr}',
                                                   style: regularSmall.copyWith(color: MyColor.colorGrey),
                                                   overflow: TextOverflow.ellipsis,
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       )),
                                       SvgPicture.asset(MyImages.playNowSVG,height: 30,width: 30,)
                                     ],
                                   ),
                                 ),
                                  const SizedBox(
                                    height: Dimensions.space3,
                                  ),
                                ],
                              ),
                            ),
                          )
                        )),
                      ),
                    ),
                  ),
                )
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
                      MyStrings.noContestFound.tr,
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
