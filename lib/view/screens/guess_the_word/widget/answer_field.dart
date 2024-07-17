import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:get/get.dart';

class AnswerField extends StatefulWidget {
  final int length;
  const AnswerField({super.key, required this.length});

  @override
  State<AnswerField> createState() => _AnswerFieldState();
}

class _AnswerFieldState extends State<AnswerField> {
  late List<int> submittedAnswer = [];
  late List<String> correctAnswerLetterList = [];
  //to controll the answer text
  late List<AnimationController> controllers = [];
  late List<Animation<double>> animations = [];
  late int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.find<GuessTheWordController>().tempAns.clear();
    for (var i = 0; i < widget.length; i++) {
      Get.find<GuessTheWordController>().tempAns.add('-1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuessTheWordController>(builder: (controller) {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: List.generate(
          controller.tempAns.length,
          (index) {
            // controller.changeTempListLenght(0);

            return GestureDetector(
              onTap: () {
                controller.selectIndex(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500), // Adjust the duration as needed
                padding: const EdgeInsets.all(Dimensions.space3),
                height: Dimensions.space40,
                width: Dimensions.space40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: controller.selectedIndex == index ? 2 : .8,
                      color: controller.selectedIndex == index ? MyColor.primaryColor : MyColor.borderColor,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    controller.tempAns[index] == '-1' ? '' : controller.tempAns[index],
                    style: semiBoldDefault.copyWith(
                      fontSize: Dimensions.fontMediumLarge,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
