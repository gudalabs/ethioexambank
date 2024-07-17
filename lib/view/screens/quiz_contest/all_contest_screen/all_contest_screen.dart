
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/quiz_contest/quiz_contest_list_controller.dart';
import 'package:quiz_lab/data/repo/quiz_contest/quiz_contest_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';
import '../../../../core/utils/my_color.dart';
import '../../../components/no_data.dart';
import 'widget/contest_title_card_widget.dart';

class AllContestScreen extends StatefulWidget {
  const AllContestScreen({super.key});

  @override
  State<AllContestScreen> createState() => _AllContestScreenState();
}

class _AllContestScreenState extends State<AllContestScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(QuizContestRepo(apiClient: Get.find()));

    QuizQuestionsListController controller = Get.put(QuizQuestionsListController(
      quizContestRepo: Get.find(),
    ));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getQuizcontestList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizQuestionsListController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: MyStrings.quizContest.tr,
        ),
        body: controller.loading == true
          ? const CustomLoader()
          : controller.examcategoryList.isEmpty
            ? SingleChildScrollView(
              child: NoDataWidget(
                  messages: MyStrings.noContestFound.tr,
                ),
            )
            : RefreshIndicator(
                color: MyColor.primaryColor,
                onRefresh: () async {
                  controller.getQuizcontestList();
                },
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: Dimensions.space15),
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    itemCount: controller.examcategoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var contestItem = controller.examcategoryList[index];
                      return ContestListTileCard(
                        onTap: () {
                          Get.toNamed(RouteHelper.quizContestQuestionscreen, arguments: [controller.examcategoryList[index].id.toString(), controller.examcategoryList[index].title.toString()])!.whenComplete(() {});
                        },
                        contest: contestItem,
                        index: index,
                        image: contestItem.image.toString(),
                      );
                    }),
              ),
      ),
    );
  }
}
