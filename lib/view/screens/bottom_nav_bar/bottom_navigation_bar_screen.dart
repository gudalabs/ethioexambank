import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/view/components/will_pop_widget.dart';
import 'package:quiz_lab/view/screens/home_page/home_screen.dart';
import 'package:quiz_lab/view/screens/leader_board/leader_board_screen.dart';
import 'package:quiz_lab/view/screens/profile/profile_screen.dart';
import 'package:quiz_lab/view/screens/settings/settings_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../../core/helper/ads/ads_unit_id_helper.dart';
import '../../../environment.dart';
import '../../components/mobile_ads/banner_ads_widget.dart';
import '../coin_store/coin_store_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int selectedIndex = 2;

  int _page = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  static final List<Widget> _widgetOptions = <Widget>[
    const CoinStoreScreen(),
    const SettingsScreen(),
    const HomeScreen(),
    const LeaderBoardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopWidget(
        fromBottomNav: selectedIndex == 2 ? false : true,
        nextRoute: selectedIndex == 2 ? "" : RouteHelper.bottomNavBarScreen,
        child: Stack(
          children: [
            Center(
              child: _widgetOptions.elementAt(_page),
            ),
            if (Environment.showBannerAds && AdUnitHelper.bannerAdUnitShow == '1') ...[
              const Positioned.fill(
                bottom: 0,
                child: Align(alignment: Alignment.bottomCenter, child: BannerAdsWidget()),
              )
            ]
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: Dimensions.space60,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(Dimensions.space2),
            child: SvgPicture.asset(
              MyImages.coinStoreDrawer,
              height: Dimensions.space35,
              width: Dimensions.space50,
              colorFilter: _page == 0 ? const ColorFilter.mode(MyColor.colorWhite, BlendMode.srcIn) : const ColorFilter.mode(MyColor.bottomNavBarIconInActiveColor, BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.space8),
            child: SvgPicture.asset(
              MyImages.settingsFilledSVG,
              height: Dimensions.space25,
              width: Dimensions.space50,
              colorFilter: _page == 1 ? const ColorFilter.mode(MyColor.colorWhite, BlendMode.srcIn) : const ColorFilter.mode(MyColor.bottomNavBarIconInActiveColor, BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.space8),
            child: SvgPicture.asset(
              MyImages.homeFilledSVG,
              height: Dimensions.space25,
              width: Dimensions.space50,
              colorFilter: _page == 2 ? const ColorFilter.mode(MyColor.colorWhite, BlendMode.srcIn) : const ColorFilter.mode(MyColor.bottomNavBarIconInActiveColor, BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.space8),
            child: SvgPicture.asset(
              MyImages.prizeFilledSVG,
              height: Dimensions.space25,
              width: Dimensions.space50,
              colorFilter: _page == 3 ? const ColorFilter.mode(MyColor.colorWhite, BlendMode.srcIn) : const ColorFilter.mode(MyColor.bottomNavBarIconInActiveColor, BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.space8),
            child: SvgPicture.asset(
              MyImages.profileFilledSVG,
              height: Dimensions.space25,
              width: Dimensions.space40,
              colorFilter: _page == 4 ? const ColorFilter.mode(MyColor.colorWhite, BlendMode.srcIn) : const ColorFilter.mode(MyColor.bottomNavBarIconInActiveColor, BlendMode.srcIn),
            ),
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: MyColor.primaryColor,
        backgroundColor: MyColor.transparentColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
