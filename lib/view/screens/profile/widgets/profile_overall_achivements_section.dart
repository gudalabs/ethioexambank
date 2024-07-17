import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/account/profile_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/util.dart';
import '../../../components/image_widget/my_image_widget.dart';

class ProfileTopSection extends StatefulWidget {
  const ProfileTopSection({super.key});

  @override
  State<ProfileTopSection> createState() => _ProfileTopSectionState();
}

class _ProfileTopSectionState extends State<ProfileTopSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
              top: Dimensions.space40,
              start: Dimensions.space18,
              end: Dimensions.space18),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.space15),
            decoration: BoxDecoration(
                color: MyColor.colorWhite,
                borderRadius: BorderRadius.circular(Dimensions.space10)),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        if (controller.apiClient.getUserImagePath() != "null")
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                                top: Dimensions.space20),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.space40),
                                border: Border.all(
                                    color: MyColor.borderColor.withOpacity(.2),
                                    width: .5)),
                            height: Dimensions.space80,
                            width: Dimensions.space80,
                            child: MyImageWidget(
                              radius: 40,
                              imageUrl: UrlContainer.dashboardUserProfileImage +
                                  controller.avatar,
                            ),
                          )
                        else
                          FittedBox(
                            fit: BoxFit.cover,
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(
                                  top: Dimensions.space20),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.space40),
                                  image: const DecorationImage(
                                      image: AssetImage(MyImages.defaultAvatar),
                                      fit: BoxFit.cover)),
                              height: Dimensions.space80,
                              width: Dimensions.space80,
                            ),
                          ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelper.profileEditScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColor.colorWhite,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.space50)),
                                child: Container(
                                    margin:
                                        const EdgeInsets.all(Dimensions.space2),
                                    padding:
                                        const EdgeInsets.all(Dimensions.space4),
                                    decoration: BoxDecoration(
                                        color: MyColor.primaryColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.space50)),
                                    child: const Icon(
                                      Icons.edit,
                                      size: Dimensions.space15,
                                      color: MyColor.colorWhite,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.space15,
                    ),
                    Text(
                      controller.apiClient
                          // .getCurrencyOrUsername(isCurrency: false),
                          .getUserFullName(),
                      style: semiBoldExtraLarge.copyWith(
                          fontSize: Dimensions.fontOverLarge),
                    ),
                    const SizedBox(
                      height: Dimensions.space40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: MyColor.transparentColor,
                            border: Border.all(
                                color: MyColor.primaryColor.withOpacity(0.05)),
                            borderRadius:
                                BorderRadius.circular(Dimensions.space8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.space10),
                                child: SvgPicture.asset(
                                    MyImages().achivementsType[0].toString()),
                              ),
                              Text(
                                MyStrings.rank.tr,
                                style: semiBoldMediumLarge.copyWith(
                                    color: MyColor.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.space5),
                                child: Text(
                                  MyUtils()
                                      .formatNumberWithLeadingZero(
                                          controller.rank)
                                      .tr,
                                  style: regularMediumLarge,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.space5,
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(
                          width: Dimensions.space10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: MyColor.transparentColor,
                            border: Border.all(
                                color: MyColor.primaryColor.withOpacity(0.05)),
                            borderRadius:
                                BorderRadius.circular(Dimensions.space8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.space10),
                                child: SvgPicture.asset(
                                    MyImages().achivementsType[1].toString()),
                              ),
                              Text(
                                MyStrings.coins.tr,
                                style: semiBoldMediumLarge.copyWith(
                                    color: MyColor.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.space5),
                                child: Text(
                                  MyUtils()
                                      .formatNumberWithLeadingZero(
                                          controller.coins)
                                      .tr,
                                  style: regularMediumLarge,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.space5,
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(
                          width: Dimensions.space10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: MyColor.transparentColor,
                            border: Border.all(
                                color: MyColor.primaryColor.withOpacity(0.05)),
                            borderRadius:
                                BorderRadius.circular(Dimensions.space8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.space10),
                                child: SvgPicture.asset(
                                    MyImages().achivementsType[2].toString()),
                              ),
                              Text(
                                MyStrings.score.tr,
                                style: semiBoldMediumLarge.copyWith(
                                    color: MyColor.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.space5),
                                child: Text(
                                  MyUtils()
                                      .formatNumberWithLeadingZero(
                                          controller.score)
                                      .tr,
                                  style: regularMediumLarge,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.space5,
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.space15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
