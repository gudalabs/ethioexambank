import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import '../../../../../components/image_widget/my_image_widget.dart';

class PlayDifferentQuizes extends StatefulWidget {
  const PlayDifferentQuizes({super.key});

  @override
  State<PlayDifferentQuizes> createState() => _PlayDifferentQuizesState();
}

class _PlayDifferentQuizesState extends State<PlayDifferentQuizes> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: Dimensions.space10,
          ),
          if (controller.differentQuizlist.isNotEmpty)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: Dimensions.space10, start: Dimensions.space5, end: Dimensions.space5, top: Dimensions.space20),
              child: Text(
                MyStrings.playDiffrentQuizs.tr,
                style: boldMediumLarge,
              ),
            ),
          const SizedBox(height: Dimensions.space10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: context.width > 600 ? 1 : 0.9),
            itemCount: controller.differentQuizlist.length,
            itemBuilder: (context, index) {
              var item = controller.differentQuizlist[index];
              return GestureDetector(
                onTap: () {
                  if (item.act == "fun") {
                    Get.toNamed(RouteHelper.funNlearnScreenScreen);
                  } else if (item.act == "guess_word") {
                    Get.toNamed(RouteHelper.guessTheWordCategory);
                  } else if (item.act == "daily_quiz") {
                    Get.toNamed(RouteHelper.dailyQuizQuestionsScreen);
                  } else if (item.act == "single_battle") {
                    Get.toNamed(RouteHelper.oneVSoneBattleScreen);
                  } else {
                    CustomSnackBar.error(errorList: [(MyStrings.serverError.tr)]);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10),
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
                  margin: const EdgeInsets.all(Dimensions.space5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                        child: MyImageWidget(
                          height: context.width * 0.14,
                          width: context.width * 0.14,
                          imageUrl: UrlContainer.playdifferentImage + controller.differentQuizlist[index].image.toString(),
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.space10,
                      ),
                      Text(
                        controller.differentQuizlist[index].name.toString().tr,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: semiBoldMediumLarge,
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Text("${controller.differentQuizlist[index].shortDescription.toString().tr} ", maxLines: 3, overflow: TextOverflow.ellipsis, style: regularDefault.copyWith(color: MyColor.textColor, fontSize: Dimensions.fontDefault12), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
