import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_images.dart';
import 'widgets/background_screen_with_card.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      appBar: CustomCategoryAppBar(title: MyStrings.leaderBoard.tr),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              MyImages.reviewBgImage,
              fit: BoxFit.cover, // Make the image cover the full width
            ),
          ),
          const SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: Dimensions.space35,
              ),
              child: BackGroundWithRankCard(), // Your existing content
            ),
          ),
        ],
      ),
    );
  }
}
