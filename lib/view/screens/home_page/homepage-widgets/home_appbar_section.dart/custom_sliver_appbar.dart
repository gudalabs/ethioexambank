import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/view/screens/home_page/homepage-widgets/home_appbar_section.dart/custom_appbar.dart';
import 'package:quiz_lab/view/screens/home_page/homepage-widgets/home_appbar_section.dart/custom_card.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final GlobalKey<ScaffoldState> scaffoldKey;
  CustomSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    required this.scaffoldKey,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    // debugPrint(percent);
    return SizedBox(
      height: expandedHeight + expandedHeight / 3,
      child: Stack(
        children: [
          CustomHomeAppBar(
            appbarSize: appBarSize,
            scaffoldKey: scaffoldKey,
          ),
          if (percent != 0)
            Positioned(
              left: 0.0,
              right: 0.0,
              top: cardTopPosition > 0 ? cardTopPosition : 0,
              bottom: 0.0,
              child: Opacity(
                opacity: percent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.space12 * percent, vertical: Dimensions.space8 * percent),
                  child: const CustomCardWidget(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
