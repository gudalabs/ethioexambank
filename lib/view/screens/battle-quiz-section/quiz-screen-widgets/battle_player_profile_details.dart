import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../data/controller/battle/battle_room_quiz_controller.dart';
import '../../../../data/model/battle/user_battle_room_details_model.dart';
import '../../../components/image_widget/my_image_widget.dart';

class BattlePlayerProfileDetails extends StatelessWidget {
  final BattleRoomQuizController quizController;
  final UserBattleRoomDetailsModel userData;
  final CountDownController countDownController;
  const BattlePlayerProfileDetails({super.key, required this.userData, required this.quizController, required this.countDownController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.space2),
          height: Dimensions.space60,
          width: Dimensions.space60,
          child: Stack(
            children: [
              CircularCountDownTimer(
                key: ValueKey<String>('${userData.uid}_${quizController.getCurrentQuestion().id}'),
                controller: countDownController,
                initialDuration: 0,
                width: Dimensions.space60,
                height: Dimensions.space60,
                ringColor: MyColor.primaryColor,
                ringGradient: null,
                fillColor: MyColor.timerbgColor,
                fillGradient: null,
                backgroundColor: MyColor.transparentColor,
                strokeWidth: Dimensions.space4,
                strokeCap: StrokeCap.round,
                textStyle: semiBoldExtraLarge.copyWith(color: MyColor.primaryColor),
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: true,
                onComplete: () {
                  // Callback function when countdown completes
                },
                onChange: (v) {
                
                  if (userData.answers.any((answer) => answer["qid"] == quizController.getCurrentQuestion().id.toString()) == true) {
                    countDownController.pause();
                  } else {
                    // countDownController.restart();
                  }
                },
                duration: quizController.duration,
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.space100),
                      child: userData.profileUrl == "null"
                          ? Image.asset(
                              MyImages.defaultAvatar,
                              fit: BoxFit.cover,
                              height: Dimensions.space50,
                              width: Dimensions.space50,
                            )
                          : MyImageWidget(
                              fromProfile: true,
                              imageUrl:"${UrlContainer.userImagePath}/${userData.profileUrl}",
                              height: Dimensions.space50,
                              width: Dimensions.space50,
                            ),
                    ),
                  ),
                ),
              ),
              if (userData.status == false)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.space100),
                    color: MyColor.colorLightGrey,
                  ),
                  width: Dimensions.space70,
                  height: Dimensions.space70,
                  child: Image.asset(MyImages.deadImage),
                )
            ],
          ),
        ),
        const SizedBox(
          height: Dimensions.space10,
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyColor),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space14),
          child: Row(
            children: [
              SvgPicture.asset(
                MyImages.greenTikSvg,
                height: Dimensions.space10,
              ),
              const SizedBox(width: Dimensions.space6),
              Text(
                "${userData.answers.where((answer) => answer["isTrue"] == "1").length}/${quizController.battleRoomController.battleQuestionsList.length}",
                style: regularDefault.copyWith(
                  fontSize: Dimensions.space10,
                  color: MyColor.rightAnswerbgColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Dimensions.space5,
        ),
        Text(
          "${userData.name} ",
          style: regularLarge.copyWith(fontSize: Dimensions.fontSmall, color: MyColor.colorBlack),
        )
      ],
    );
  }
}
