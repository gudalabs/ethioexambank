import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/leader_board/leader_board_controller.dart';
import 'package:quiz_lab/data/repo/leaderBoard/leader_board_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/my_color.dart';
import '../../../components/image_widget/my_image_widget.dart';
import 'ranking_tabs.dart';

class BackGroundWithRankCard extends StatefulWidget {
  const BackGroundWithRankCard({super.key});

  @override
  State<BackGroundWithRankCard> createState() => _BackGroundWithRankCardState();
}

class _BackGroundWithRankCardState extends State<BackGroundWithRankCard> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LeaderBoardRepo(apiClient: Get.find()));
    LeaderBoardController controller = Get.put(LeaderBoardController(leaderBoardRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return GetBuilder<LeaderBoardController>(
      builder: (controller) => controller.isLoading ?
      SizedBox(
        height: context.height / 2,
        child: const Center(
          child: CustomLoader(isPagination: true,)
        ),
      )
      : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.space10),
              child: RankingTabBar(
                controller: controller,
              ),
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    MyImages.leaderBoardRankSVG,
                    height: context.width / 3.5,
                  ),
                ),
                controller.isLoading ?
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: context.width / 4.05,
                  ),
                  child: const CustomLoader(isPagination: true),
                  ) :
                Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsetsDirectional.only(
                      top: context.width / 4.05,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.space20),
                        topRight: Radius.circular(Dimensions.space20),
                      ),
                      color: MyColor.colorWhite,
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: MyColor.transparentColor,
                        );
                      },
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.leaderBoardlist.length - 3 >= 0 ? controller.leaderBoardlist.length - 3 : 0,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.leaderBoardlist[index + 3];
                        int ranking = index + 4;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: MyColor.colorWhite,
                            boxShadow: [
                              BoxShadow(
                                color: MyColor.colorBlack.withOpacity(0.10),
                                offset: const Offset(0.0, 8.0),
                                blurRadius: 60.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.space10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                item.avatar.toString() != "null" ? Container(
                                    margin: EdgeInsets.all(
                                      orientation != Orientation.portrait ? Dimensions.space10 : Dimensions.space8,
                                    ),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    height: orientation != Orientation.portrait ? Dimensions.space60 : Dimensions.space60,
                                    width: orientation != Orientation.portrait ? Dimensions.space60 : Dimensions.space60,
                                    child: MyImageWidget(radius: Dimensions.space100, imageUrl: UrlContainer.leaderboardProfileImage + item.avatar.toString()),
                                  )
                                : Container(
                                    margin: EdgeInsets.all(
                                      orientation != Orientation.portrait ? Dimensions.space10 : Dimensions.space8,
                                    ),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    height: orientation != Orientation.portrait ? Dimensions.space60 : Dimensions.space60,
                                    width: orientation != Orientation.portrait ? Dimensions.space60 : Dimensions.space60,
                                    child: Image.asset(MyImages.defaultAvatar),
                                  ),
                                const SizedBox(
                                  width: Dimensions.space10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (item.fullName.toString().isEmpty ? item.username : item.fullName.toString()).tr,
                                        style: semiBoldMediumLarge,
                                      ),
                                      const SizedBox(height: Dimensions.space5),
                                      Row(
                                        children: [
                                          Text(
                                            "${item.score} ${MyStrings.points.tr}",
                                            style: semiBoldLarge.copyWith(color: MyColor.textColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '$ranking',
                                  style: semiBoldOverLarge.copyWith(color: MyColor.greyTextColor.withOpacity(0.6), fontSize: Dimensions.fontOverLarge30),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  ),
              ],
            ),
          ],
        ),
    );
  }
}
