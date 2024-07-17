import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/no_data.dart';
import 'package:quiz_lab/view/screens/drawer/drawer_screen.dart';
import 'package:quiz_lab/view/screens/home_page/homepage-widgets/home-body-sections/exam_zone_section/exam_zone_homepage_category_screen.dart';
import 'package:quiz_lab/view/screens/home_page/homepage-widgets/home-body-sections/home_top_category_section/top_category_section.dart';
import 'package:get/get.dart';
import '../../../core/helper/ads/admob_helper.dart';
import '../../../core/helper/ads/ads_unit_id_helper.dart';
import '../../../data/controller/dashboard/dashboard_controller.dart';
import '../../../data/controller/quiz_contest/quiz_contest_questions_controller.dart';
import '../../../data/controller/sub_categories/sub_categories_controller.dart';
import '../../../data/repo/auth/logout/logout_repo.dart';
import '../../../data/repo/dashboard/dashboard_repo.dart';
import '../../../data/repo/quiz_contest/quiz_contest_repo.dart';
import '../../../data/repo/sub_categories/sub_categories_repo.dart';
import '../../../data/services/api_client.dart';
import 'homepage-widgets/home-body-sections/play_diffrent_quizes/play_diffrent_quizes.dart';
import 'homepage-widgets/home_appbar_section.dart/custom_sliver_appbar.dart';

import 'homepage-widgets/home-body-sections/contest_section/quiz_contest_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AdmobHelper admobHelper = AdmobHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DashBoardRepo(apiClient: Get.find()));
    Get.put(ExamZoneRepo(apiClient: Get.find()));
    Get.put(SubCategoriesRepo(apiClient: Get.find()));
    Get.put(SubCategoriesController(subCategoriesRepo: Get.find()));

    Get.put(QuizContestRepo(apiClient: Get.find()));

    Get.put(QuizContestQuestionsController(quizContestRepo: Get.find()));

    DashBoardController controller = Get.put(DashBoardController(dashRepo: Get.find(), examZoneRepo: Get.find(), logoutRepo: Get.put(LogoutRepo(apiClient: Get.find()))));
    AdUnitHelper.initializeAdUnits();
    admobHelper.createInterstitialAd();

    controller.getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: GetBuilder<DashBoardController>(
        builder: (controller) {
          return RefreshIndicator(
            color: MyColor.primaryColor,
            onRefresh: () async {
              controller.getHomePageData(fromRefresh: true);
            },
            child: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: CustomSliverDelegate(
                      expandedHeight: Dimensions.space125,
                      scaffoldKey: _scaffoldKey,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.space10),
                      child: controller.loader
                          ? SizedBox(
                              height: context.height / 2,
                              child: const Center(child: CustomLoader()),
                            )
                          : controller.generalQuizStatus == '0' && controller.contestStatus == '0' && controller.examStatus == '0' && controller.differentQuizlist.isEmpty
                              ? const NoDataWidget(
                                  margin: 10,
                                  hideButton: true,
                                )
                              : Column(
                                  children: [
                                    if (controller.generalQuizStatus == '1') ...[
                                      const TopCategorySection(),
                                    ],
                                    // BattleOfTheDaySection(),
                                    if (controller.contestStatus == '1') ...[
                                      const QuizContestSection(),
                                    ],

                                    if (controller.examStatus == '1') ...[
                                      const ExamZoneSection(),
                                    ],

                                    const PlayDifferentQuizes(),

                                    const SizedBox(
                                      height: Dimensions.space70,
                                    )
                                  ],
                                ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      drawer: const DrawerScreen(),
    );
  }
}
