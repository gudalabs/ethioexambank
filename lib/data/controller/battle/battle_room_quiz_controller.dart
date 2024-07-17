// class BattleRoomQuizController

import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helper/battle_room_helper.dart';
import '../../../core/route/route.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/battle/battle_room_data_model.dart';
import '../../model/battle/battle_question_list.dart';
import '../../model/battle/battle_result_submit_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/battle/battle_repo.dart';
import 'battle_room_controller.dart';
import 'package:wakelock/wakelock.dart';

class BattleRoomQuizController extends GetxController with GetTickerProviderStateMixin, WidgetsBindingObserver {
  BattleRepo battleRepo;
  final BattleRoomController battleRoomController;

  BattleRoomQuizController(this.battleRoomController, this.battleRepo);
  StreamSubscription<DocumentSnapshot>? battleRoomStreamSubscription;
  final int duration = 60;

  final CountDownController countDownController = CountDownController();
  //Current User CountDown Controller\
  final CountDownController myCountDownController = CountDownController();
  //Opponent User CountDown Controller
  final CountDownController opUserCountDownController = CountDownController();

  final RxList<BattleQuestion> questionsList = <BattleQuestion>[].obs;
  late AnimationController _listAnimationController;
  AnimationController get listAnimationController => _listAnimationController;

  // Map to track selected options for each question
  final Map<int, BattleQuestionOption?> selectedOptions = <int, BattleQuestionOption?>{};

  int currentQuestionIndex = 0;
  final opponentLeftTheGame = false.obs;
  final showLeftPopupValue = false.obs;
  final meLeftTheGame = false.obs;

  //Answer
  final isAnsSubmitting = false.obs;

  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  int previousQuestionId = -1; // Initialize with a value that won't match any valid question id

  @override
  void onInit() {
    super.onInit();
    _listAnimationController = AnimationController(
      vsync: this,
      // Adjust duration as needed
    );

    setupBattleRoomSubmitListener();
    // The following line will enable the Android and iOS wakelock.
    Wakelock.enable();

    // Register the WidgetsBindingObserver
    WidgetsBinding.instance.addObserver(this);
  }

  showLeftPopupUpdate(bool value) {
    showLeftPopupValue(value);
    update();
  }

  showMeLeftPopupUpdate(bool value) {
    meLeftTheGame(value);
    update();
  }

  void selectOptionForQuestion(int questionId, BattleQuestionOption option) {
    if (!selectedOptions.containsKey(questionId)) {
      selectedOptions[questionId] = option;
    }
    update();
  }

  bool isOptionSelectedForQuestion(int questionId, BattleQuestionOption option) {
    return selectedOptions.containsKey(questionId) && selectedOptions[questionId] == option;
  }

//Update LIst Animation
  void updateAnimatedListKeyIfNeeded(int newQuestionId) {
    if (newQuestionId != previousQuestionId) {
      animatedListKey = GlobalKey<AnimatedListState>();
      previousQuestionId = newQuestionId;
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      countDownController.restart(duration: duration);
    }
    update();
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questionsList.length - 1) {
      currentQuestionIndex++;
      countDownController.restart(duration: duration);
    }

    update();
  }

  BattleQuestion getCurrentQuestion() {
    if (currentQuestionIndex >= 0 && currentQuestionIndex < questionsList.length) {
      return questionsList[currentQuestionIndex];
    }

    // Return a placeholder question if index is out of bounds
    return BattleQuestion(
      id: -1,
      question: 'Question not found',
      image: null,
      code: '',
      status: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      options: [],
    );
  }

  bool hasMoreQuestions() {
    return currentQuestionIndex < questionsList.length - 1;
  }

  bool hasSubmittedAnswerForQuestion(int questionId) {
    return selectedOptions.containsKey(questionId);
  }

  toogleSubmitAns(bool value) {
    isAnsSubmitting.value = value;
    update();
  }
  // Firebase

  Stream<DocumentSnapshot> listenToBattleRoomDocument(String battleRoomDocumentId) {
    return battleRoomController.firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(battleRoomDocumentId).snapshots();
  }

//Listen Firebase Data
  void setupBattleRoomSubmitListener() {
    debugPrint("From Quiz Stream");
    battleRoomStreamSubscription = listenToBattleRoomDocument(battleRoomController.battleRoomData.value!.roomId!).listen((event) {
      if (event.exists) {
        checkUserAnswer(battleRoomController.battleRoomData.value!);
      } else {
        debugPrint("Room Deleted");
      }
    });
  }

  showLeftPopup({bool isUpdate = false}) {
    if (showLeftPopupValue.isFalse) {
      // debugPrint("Checking If User Left The match");
      var battleData = battleRoomController.battleRoomData.value!;

      // im am user 1
      if (battleRepo.apiClient.getUserID() == battleData.user1!.uid) {
        if (battleData.user2!.status == false) {
          debugPrint("${battleData.user2!.name} Left The game");
          opponentLeftTheGame.value = true;
          if (isUpdate) {
            update();
          }
        }
      }
      // im am user 2
      if (battleRepo.apiClient.getUserID() == battleData.user2!.uid) {
        if (battleData.user1!.status == false) {
          debugPrint("${battleData.user1!.name} Left The game");
          opponentLeftTheGame.value = true;
          if (isUpdate) {
            update();
          }
        }
      }
    }
  }

  void checkUserAnswer(BattleRoomDataModel battleRoom) {
    List user1Answers = battleRoom.user1!.answers;
    List user2Answers = battleRoom.user2!.answers;
    String currentQuestionId = questionsList[currentQuestionIndex].id.toString();
    if (user1Answers.isEmpty || user2Answers.isEmpty) {
      if (user1Answers.isNotEmpty && user2Answers.isEmpty) {
        debugPrint("User 2 hasn't answered yet, while User 1 has answered.");
      } else if (user1Answers.isEmpty && user2Answers.isNotEmpty) {
        debugPrint("User 1 hasn't answered yet, while User 2 has answered.");
      }
    } else {
      bool user1AnsweredCurrent = user1Answers.any((answer) => answer["qid"].toString() == currentQuestionId);
      bool user2AnsweredCurrent = user2Answers.any((answer) => answer["qid"].toString() == currentQuestionId);

      if (user1AnsweredCurrent && user2AnsweredCurrent) {
        debugPrint("Both users have answered the current and next questions, and timer completed");

        if (hasMoreQuestions()) {
          goToNextQuestion();
        } else {
          finishBattleAndSubmitAnswer();
        }
      }
    }
  }

//Submit Answer Data to server
  Future finishBattleAndSubmitAnswer({bool fromYouWon = false}) async {
    toogleSubmitAns(true);
    var ownData = battleRoomController.getOpponentUserDetailsOrMy(battleRepo.apiClient.getUserID(), isMyData: true); // Current User Data
    var opUserData = battleRoomController.getOpponentUserDetailsOrMy(battleRepo.apiClient.getUserID()); // Opponent Data

    Map<String, dynamic> params = {};

    params['opponent_id'] = opUserData.uid.toString();
    params['coin_count'] = battleRoomController.battleRoomData.value!.entryFee.toString(); // coin_count value

    // Loop through the questionsList
    for (int i = 0; i < questionsList.length; i++) {
      String quizeId = questionsList[i].id.toString();
      // Add question_id to params
      params['question_id[$i]'] = quizeId.toString();
      // Find the answer object with the matching qid for ownData and opUserData
      var ownAnswerIfLeftOP = questionsList.firstWhere(
        (qus) => qus.id.toString() == quizeId,
      );
      var ownAnswer = ownData.answers.firstWhere((answer) => answer['qid'] == quizeId, orElse: () => null);
      var opUserAnswer = opUserData.answers.firstWhere((answer) => answer['qid'] == quizeId, orElse: () => null);

      if (fromYouWon == false) {
        if (ownAnswer != null) {
          int selectedOptionIdOwn = ownAnswer['ans']; //'ans' holds the selected option index
          params['my_option_$quizeId'] = selectedOptionIdOwn.toString();
        }
      } else {
        var optionID = ownAnswerIfLeftOP.options.where((element) => element.isAnswer == "1");

        params['my_option_$quizeId'] = "${optionID.first.id}";

        // debugPrint(optionID.first.id);
      }

      if (fromYouWon == false) {
        if (opUserAnswer != null) {
          int selectedOptionIdOP = opUserAnswer['ans']; //  'ans' holds the selected option index
          params['opponent_option_$quizeId'] = selectedOptionIdOP.toString();
        }
      } else {
        params['opponent_option_$quizeId'] = "0";
      }
    }

    // debugPrint(params);

    ResponseModel submitModel = await battleRepo.finishBattleAndSubmitAnswer(params);
    debugPrint(submitModel.statusCode.toString());
    if (submitModel.statusCode == 200) {
      BattleAnswerSubmitModel submitAnswerModel = battleAnswerSubmitModelFromJson(submitModel.responseJson);
      var battleRoomData = battleRoomController.battleRoomData.value;

      await battleRoomController.deleteBattleRoom(battleRoomController.battleRoomData.value!.roomId, false).whenComplete(() {
        if (fromYouWon == false) {
          if (submitAnswerModel.message.error!.isEmpty) {
            // Get.back();
            Get.offAndToNamed(RouteHelper.battleQuizResultScreen, arguments: [submitAnswerModel, battleRoomData]);
          } else {
            CustomSnackBar.error(errorList: [...submitAnswerModel.message.error!, ...submitAnswerModel.message.success!]);
            Get.offAllNamed(RouteHelper.bottomNavBarScreen);
          }
        } else {
          Get.offAllNamed(RouteHelper.bottomNavBarScreen);
        }
      });
      toogleSubmitAns(false);
    } else {
      CustomSnackBar.error(errorList: [submitModel.message]);
      toogleSubmitAns(false);
      return;
    }

    // update();
  }

  @override
  void onClose() {
    battleRoomStreamSubscription!.cancel();
    // The next line disables the wakelock again.
    Wakelock.disable();

    // Unregister the WidgetsBindingObserver
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    // Handle the app lifecycle changes here
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint('App resumed');
        // Reactivate any necessary functionality
        // debugPrint(battleRoomController.getOpponentUserDetailsOrMy(battleRepo.apiClient.getUserID(), isMyData: true).status);

        if (battleRoomController.getOpponentUserDetailsOrMy(battleRepo.apiClient.getUserID(), isMyData: true).status == false) {
          showMeLeftPopupUpdate(true);
        }

        break;
      case AppLifecycleState.inactive:
        debugPrint('App inactive');
        // Handle when the app is in an inactive state (e.g., during a phone call)
        break;
      case AppLifecycleState.paused:
        debugPrint('App paused');
        if (opponentLeftTheGame.isTrue) {
          // left User
          await battleRoomController
              .deleteBattleRoom(
            battleRoomController.battleRoomData.value!.roomId,
            false,
          )
              .whenComplete(() {
            // Get.offAll(RouteHelper.bottomNavBarScreen);
          });
        } else {
          countDownController.pause();
          // left User
          await battleRoomController.leftBattleRoomFirebase(battleRoomController.battleRoomData.value!.roomId, false, currentUserId: battleRepo.apiClient.getUserID()).whenComplete(() {
            // Get.offAll(RouteHelper.bottomNavBarScreen);
          });
        }
        break;
      case AppLifecycleState.detached:
        debugPrint('App detached');
        // Handle when the app is detached (not available on all platforms)
        break;

      default:
        // Handle any other cases that might be added in the future
        break;
    }
  }
}
