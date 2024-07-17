import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/privacy/privacy_controller.dart';
import '../../../data/repo/privacy_repo/privacy_repo.dart';
import '../../../data/services/api_client.dart';
import '../../components/app-bar/custom_category_appbar.dart';
import '../../components/buttons/category_button.dart';
import '../../components/custom_loader/custom_loader.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PrivacyRepo(apiClient: Get.find()));
    final controller = Get.put(PrivacyController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.colorWhite,
        appBar: CustomCategoryAppBar(
          title: MyStrings.privacyPolicy.tr,
          // systemUiOverlayStyle: SystemUiOverlayStyle(statusBarColor: MyColor.colorWhite, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: MyColor.getPrimaryColor(), systemNavigationBarIconBrightness: Brightness.light),
        ),
        body: GetBuilder<PrivacyController>(
          builder: (controller) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? const CustomLoader()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: Dimensions.space10, top: Dimensions.space15),
                        child: SizedBox(
                          height: 30,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                controller.list.length,
                                (index) => Row(
                                  children: [
                                    CategoryButton(
                                        color: controller.selectedIndex == index ? MyColor.primaryColor : MyColor.secondaryColor,
                                        horizontalPadding: 8,
                                        verticalPadding: 7,
                                        textColor: controller.selectedIndex == index ? MyColor.colorWhite : MyColor.colorBlack,
                                        text: controller.list[index].dataValues?.title ?? '',
                                        press: () {
                                          controller.changeIndex(index);
                                        }),
                                    const SizedBox(width: Dimensions.space10)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              color: Colors.transparent,
                              child: HtmlWidget(
                                controller.selectedHtml,
                                textStyle: regularDefault.copyWith(color: Colors.black),
                                onLoadingBuilder: (context, element, loadingProgress) => const Center(
                                  child: CustomLoader(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ));
  }
}
