import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/battle/battle_question_list.dart';
import '../../model/battle/battle_category_list.dart';
import 'package:quiz_lab/data/repo/battle/battle_repo.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

import '../../../core/helper/battle_room_helper.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/internet_connectivity.dart';
import '../../model/battle/battle_room_data_model.dart';
import '../../model/battle/battle_room_exeption.dart';
import '../../model/battle/user_battle_room_details_model.dart';

enum RoomCreateState {
  none,
  creatingRoom,
  roomCreated,
  failed,
  roomFound,
  roomNotFound,
  deleted,
}

enum JoinRoomState {
  none,
  joining,
  joined,
  aleadyJoined,
  failed,
  full,
}

enum UserFoundState {
  none,
  found,
  notFound,
  left,
}

enum BattleGameState {
  notStartede,
  started,
  end,
  error,
}

class BattleRoomController extends GetxController {
  BattleRepo battleRepo;
  BattleRoomController(this.battleRepo);
  StreamSubscription<DocumentSnapshot>? _battleRoomStreamSubscription;
  StreamSubscription<DocumentSnapshot>? get battleRoomStreamSubscription => _battleRoomStreamSubscription;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  get firebaseFirestore => _firebaseFirestore;
  Rx<RoomCreateState> roomCreateState = RoomCreateState.none.obs;
  Rx<JoinRoomState> joinRoomState = JoinRoomState.none.obs;
  Rx<UserFoundState> userFoundState = UserFoundState.none.obs;
  final Random _randomRoomID = Random.secure();
  Rx<BattleRoomDataModel?> battleRoomData = Rx<BattleRoomDataModel?>(null);
  final battleQuestionsList = <BattleQuestion>[].obs;
  final alreadyJoined = false.obs;

  //Custom Room Setup
  final categoryList = <BattleCategory>[].obs;
  final categoryListArgs = Get.arguments == null ? <BattleCategory>[] : Get.arguments[2] as List<BattleCategory>;
  final slectedCategoryID = 0.obs;
  final entryFeeCustomRoom = "0".obs;

// Random Room COde
  String generateRoomCode(int length) => String.fromCharCodes(Iterable.generate(length, (_) => BattleRoomHelper.roomCodeGenerateCharacters.codeUnitAt(_randomRoomID.nextInt(BattleRoomHelper.roomCodeGenerateCharacters.length))));

  toogleBattleCreatedState(RoomCreateState value) {
    roomCreateState.value = value;
    update();
  }

  toogleBattleJoinedState(JoinRoomState value) {
    joinRoomState.value = value;
    update();
  }

  toogleUserFoundState(UserFoundState value) {
    userFoundState.value = value;
    update();
  }

  toogleAlreadyJoined(bool value) {
    alreadyJoined.value = true;
    update();
  }

  //Select A Category
  slectACategory(int value) {
    slectedCategoryID.value = value;
    update();
  }

  //Set Category To This CategoryList
  setCategoryData() {
    if (categoryListArgs.isNotEmpty) {
      categoryList.addAll([...categoryListArgs]);
    }
    update();
  }

  //Set  Entry Fee
  setEntryFeeCustomRoom(String value) {
    entryFeeCustomRoom.value = value;
    update();
  }

// Craete A Room
  void createNewRoom({required String categoryId, String? name, String? profileUrl, String? uid, int? entryFee, required bool shouldGenerateRoomCode, required List<BattleQuestion> questionList}) async {
    try {
      toogleBattleCreatedState(RoomCreateState.creatingRoom);
      debugPrint("From Create Room");

      String roomCode = "";
      if (shouldGenerateRoomCode) {
        roomCode = generateRoomCode(6);
      }
      debugPrint("Room Code $roomCode");

      final DocumentSnapshot craeteNewRoomSnapshot = await createBattleRoomFirebase(categoryId: categoryId, name: name!, profileUrl: profileUrl!, uid: uid!, roomCode: roomCode, entryFee: entryFee, questionList: questionList);

      BattleRoomDataModel.fromDocumentSnapshot(craeteNewRoomSnapshot);

      subscribeToBattleRoom(
        craeteNewRoomSnapshot.id,
        questionList,
        false,
      );
    } catch (e) {
      toogleBattleCreatedState(RoomCreateState.failed);
      debugPrint(e.toString());
      throw BattleRoomException(errorMessageCode: e.toString());
    }
  }

  //subscribe battle room
  void subscribeToBattleRoom(
    String battleRoomDocumentId,
    List<BattleQuestion> questions,
    bool forMultiUser,
  ) {
    //for realtimeness
    _battleRoomStreamSubscription = subscribeToBattleRoomFirebase(battleRoomDocumentId, forMultiUser).listen((event) async {
      if (event.exists) {
        BattleRoomDataModel battleRoom = BattleRoomDataModel.fromDocumentSnapshot(event);

        bool? userNotFound = battleRoom.user2?.uid.isEmpty;

        //if opponent userId is empty menas we have not found any user
        if (userNotFound == true) {
          debugPrint("User Not Found ${userFoundState.value}");

          if (userFoundState.value == UserFoundState.found) {
            debugPrint("One of the user left the room");
          }
          //Room Created
          battleRoomData.value = battleRoom;
          if (roomCreateState.value != RoomCreateState.roomCreated) {
            toogleBattleCreatedState(RoomCreateState.roomCreated);
          }
        } else {
          battleRoomData.value = battleRoom;

          debugPrint("User Found ${joinRoomState.value}");

          // if user found then get question list from api

          if (joinRoomState.value != JoinRoomState.aleadyJoined) {
            if (joinRoomState.value != JoinRoomState.joined) {
              toogleBattleJoinedState(JoinRoomState.joined);
              toogleUserFoundState(UserFoundState.found);

              //Fetch Questions if i creator

              var ownData = getOpponentUserDetailsOrMy(battleRepo.apiClient.getUserID(), isMyData: true); // Current User Data
              var opUserData = getOpponentUserDetailsOrMy(battleRepo.apiClient.getUserID()); // Opponent Data

              debugPrint("User 2  Name : ${opUserData.name}");
              //Get random question from api and update to firebase adn use it for 2 user

              if (ownData.uid == battleRoom.user1!.uid) {
                await getRandomBattleQuestions(
                  int.parse(battleRoom.categoryId!),
                  int.parse(ownData.uid),
                  int.parse(opUserData.uid),
                ).then((value) async {
                  await updateQuestionsListInBattleRoomFirebase(battleRoom.roomId!, value).then((value) {
                    update();
                    final List<dynamic> existingQuestionsData = json.decode(battleRoomData.value!.questionsList!);
                    final List<BattleQuestion> existingQuestionsList = existingQuestionsData.map((item) => BattleQuestion.fromJson(item)).toList();

                    battleQuestionsList.value = existingQuestionsList;
                    update();
                  });
                });
              }
            }
          }

          if (joinRoomState.value != JoinRoomState.aleadyJoined && battleRoom.readyToPlay == true) {
            if (battleQuestionsList.isEmpty) {
              Get.back();

              CustomSnackBar.error(errorList: [MyStrings.questionNotFoundMsg.tr]);
              deleteBattleRoom(battleRoom.roomId, false);
            } else {
              debugPrint("called from here to quiz page");
              Get.back();

              Get.offAndToNamed(
                RouteHelper.battleQuizQuestionsScreen,
                arguments: ["${"${battleRoom.user1!.name} VS ${battleRoom.user2!.name}"} ", battleQuestionsList, categoryList],
              );
            }

            toogleBattleJoinedState(JoinRoomState.aleadyJoined);
          }
        }
      } else {
        if (userFoundState.value == UserFoundState.found) {
          debugPrint("Delete Room Close PopUp");
          debugPrint("One of the user left the room");
          toogleUserFoundState(UserFoundState.left);
          toogleBattleCreatedState(RoomCreateState.deleted);
          Get.back();
        }
      }
    }, onError: (e) {
      toogleBattleCreatedState(RoomCreateState.failed);
      toogleBattleJoinedState(JoinRoomState.failed);
      toogleUserFoundState(UserFoundState.none);
    }, cancelOnError: true);
  }

//to join battle room
  Future joinRoom({
    String? name,
    String? profileUrl,
    String? uid,
    String? roomCode,
    required String currentCoin,
    required bool joinroom,
  }) async {
    try {
      debugPrint(roomCode);
      toogleBattleJoinedState(JoinRoomState.joining);
      final result = await joinBattleRoomFriendFirebase(
        name: name,
        profileUrl: profileUrl,
        roomCode: roomCode,
        uid: uid,
        joinroom: joinroom,
        currentCoin: int.parse(currentCoin),
      );

      subscribeToBattleRoom(
        result['roomId'],
        result['questions'],
        false,
      );
    } catch (e) {
      debugPrint("Join BattleFailureError ${e.toString()}");

      toogleBattleJoinedState(JoinRoomState.failed);
      if (e.toString() == "roomIsFullCode") {
        toogleBattleJoinedState(JoinRoomState.full);
        CustomSnackBar.error(errorList: [(MyStrings.sorryRoomISFull.tr)]);
      } else if (e.toString() == "notEnoughCoinsCode") {
        toogleBattleJoinedState(JoinRoomState.failed);
        CustomSnackBar.error(errorList: [(MyStrings.youHaveNoCoins.tr)]);
      } else if (e.toString() == "roomCodeInvalidCode") {
        toogleBattleJoinedState(JoinRoomState.failed);
        CustomSnackBar.error(errorList: [(MyStrings.roomCodeIsWrong.tr)]);
      } else {
        CustomSnackBar.error(errorList: [(e.toString())]);
      }
    }
  }

  // Get battle Questions From Api IF USER FOUND
  Future<List<BattleQuestion>> getRandomBattleQuestions(int id, int user1ID, int user2ID) async {
    final model = await battleRepo.getBatttleQuestion(id, user1ID, user2ID);

    if (model.statusCode == 200) {
      final quizquestions = battleQuestionListFromJson(model.responseJson);

      if (quizquestions.status.toLowerCase() == MyStrings.success.toLowerCase()) {
        final questionList = quizquestions.data.questions;

        if (questionList.isNotEmpty) {
          return questionList;
        }
      }
    }
    return [];
  }

//join multi user battle room
  Future<Map<String, dynamic>> joinBattleRoomFriendFirebase({String? name, String? profileUrl, String? uid, String? roomCode, int? currentCoin, required bool joinroom}) async {
    try {
      //verify roomCode is valid or not
      QuerySnapshot querySnapshot = await getMultiUserBattleRoomFirebase(roomCode, "battle");

      //invalid room code
      if (querySnapshot.docs.isEmpty) {
        throw BattleRoomException(errorMessageCode: "roomCodeInvalidCode"); //invalid roomcode
      }

      //game started code
      if ((querySnapshot.docs.first.data() as Map<String, dynamic>)['readyToPlay'] == true) {
        throw BattleRoomException(errorMessageCode: "gameStartedCode");
      }

      //not enough coins
      if ((querySnapshot.docs.first.data() as Map<String, dynamic>)['entryFee'] > currentCoin) {
        throw BattleRoomException(errorMessageCode: "notEnoughCoinsCode");
      }

      // debugPrint("GetSomeData ${questionsData.data.toJson()}");

      //get roomRef
      DocumentReference documentReference = querySnapshot.docs.first.reference;
      //using transaction so we get latest document before updating roomDocument
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        //get latest document
        DocumentSnapshot documentSnapshot = await documentReference.get();
        Map user2Details = Map.from(documentSnapshot.data() as Map<String, dynamic>)['user2'];

        if (user2Details['uid'].toString().isEmpty) {
          //join as user2
          transaction.update(documentReference, {
            "user2.name": name,
            "user2.uid": uid,
            "user2.profileUrl": profileUrl,
            "user2.status": joinroom,
          });
        } else {
          //room is full
          throw BattleRoomException(errorMessageCode: "roomIsFullCode");
        }
        return {"roomId": documentSnapshot.id, "questions": <BattleQuestion>[]};
      });
    } catch (e) {
      throw BattleRoomException(errorMessageCode: e.toString());
    }
  }

  Future<void> startBattleQuiz(String? battleRoomDocumentId, String battle, {bool readyToPlay = true}) async {
    try {
      updateMultiUserRoom(battleRoomDocumentId, {"readyToPlay": readyToPlay}, battle);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

// Start Main Search Random Battle room

  void randomSearchRoom({
    required String categoryId,
    required String name,
    required String profileUrl,
    required String uid,
    required String entryCoin,
    required List<BattleQuestion> questionList,
  }) async {
    try {
      List<DocumentSnapshot> documents = await randomSearchBattleRoom(
        categoryId: categoryId,
        name: name,
        profileUrl: profileUrl,
        uid: uid,
      );

      if (documents.isNotEmpty) {
        //find any random room
        DocumentSnapshot room = documents[Random.secure().nextInt(documents.length)];

        final searchAgain = await randomJoinBattleRoom(
          battleRoomDocumentId: room.id,
          name: name,
          profileUrl: profileUrl,
          uid: uid,
          categoryId: categoryId,
        );
        if (searchAgain) {
          //if user falis to join room then searchAgain
          randomSearchRoom(
            categoryId: categoryId,
            name: name,
            profileUrl: profileUrl,
            uid: uid,
            entryCoin: entryCoin,
            questionList: questionList,
          );
        } else {
          subscribeToBattleRoom(
            room.id,
            questionList,
            false,
          );
        }
      } else {
        createNewRoom(
          categoryId: categoryId,
          entryFee: int.parse(entryCoin),
          name: name,
          profileUrl: profileUrl,
          shouldGenerateRoomCode: false,
          uid: uid,
          questionList: questionList,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //to join battle room (one to one)
  Future<bool> randomJoinBattleRoom({
    String? battleRoomDocumentId,
    String? name,
    String? profileUrl,
    String? uid,
    required String categoryId,
  }) async {
    try {
      return await joinBattleRoomFirebase(battleRoomDocumentId: battleRoomDocumentId, name: name, profileUrl: profileUrl, uid: uid, categoryId: categoryId);
    } catch (e) {
      throw BattleRoomException(errorMessageCode: e.toString());
    }
  }

  //search battle room
  Future<List<DocumentSnapshot>> randomSearchBattleRoom({
    required String categoryId,
    required String name,
    required String profileUrl,
    required String uid,
  }) async {
    try {
      final documents = await searchBattleRoom(categoryId);

      //if room is created by user who is searching the room then delete room
      //so user will not join room that was created by him/her self
      int index = documents.indexWhere((element) => (element.data() as Map<String, dynamic>)['createdBy'] == uid);
      if (index != -1) {
        deleteBattleRoom(documents[index].id, false);
        documents.removeAt(index);
      }
      return documents;
    } catch (e) {
      throw BattleRoomException(errorMessageCode: e.toString());
    }
  }

  UserBattleRoomDetailsModel getOpponentUserDetailsOrMy(String currentUserId, {bool isMyData = false}) {
    if (userFoundState.value == UserFoundState.found) {
      if (isMyData) {
        if (currentUserId == battleRoomData.value!.user1?.uid) {
          return battleRoomData.value!.user1!;
        } else {
          return battleRoomData.value!.user2!;
        }
      } else {
        if (currentUserId == battleRoomData.value!.user1?.uid) {
          return battleRoomData.value!.user2!;
        } else {
          return battleRoomData.value!.user1!;
        }
      }
    }
    return UserBattleRoomDetailsModel(points: 0, answers: [], correctAnswers: 0, name: "name", profileUrl: "profileUrl", uid: "uid", status: false);
  }

//Firebase Part

  //to create room to play quiz
  Future<DocumentSnapshot> createBattleRoomFirebase({
    required String categoryId,
    required String name,
    required String profileUrl,
    required String uid,
    String? roomCode,
    int? entryFee,
    required List<BattleQuestion> questionList,
  }) async {
    try {
      //hasLeft,categoryId
      DocumentReference documentReference = await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).add({
        "createdBy": uid,
        "categoryId": categoryId,
        "roomCode": roomCode ?? "",
        "entryFee": entryFee ?? 0,
        "readyToPlay": false,
        "user1": {"name": name, "points": 0, "answers": [], "uid": uid, "profileUrl": profileUrl, "status": true},
        "user2": {"name": "", "points": 0, "answers": [], "uid": "", "profileUrl": "", "status": false},
        "createdAt": Timestamp.now(),
        "questions_list": json.encode(questionList.map((question) => question.toJson()).toList()),
      });
      return await documentReference.get();
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  //Update QuestionList
  Future<void> updateQuestionsListInBattleRoomFirebase(String documentId, List<BattleQuestion> questionList) async {
    try {
      final DocumentReference documentReference = _firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(documentId);
      final DocumentSnapshot documentSnapshot = await documentReference.get();
      final Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      if (data['questions_list'] == "[]") {
        await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(documentId).update({
          "questions_list": json.encode(questionList.map((question) => question.toJson()).toList()),
        });
        if (kDebugMode) {
          print("update --------------------------------------update");
        }
      }
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

//to create room to play quiz
  Future<bool> joinBattleRoomFirebase({String? name, String? profileUrl, String? uid, String? battleRoomDocumentId, required String categoryId}) async {
    try {
      DocumentReference documentReference = (await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(battleRoomDocumentId).get()).reference;
      debugPrint("Join user here ");
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        //get latest document
        DocumentSnapshot documentSnapshot = await documentReference.get();
        Map documentSnapshotDetails = Map.from(documentSnapshot.data() as Map<String, dynamic>);
        Map user2Details = Map.from(documentSnapshotDetails)['user2'];

        if (user2Details['uid'].toString().isEmpty && Map.from(documentSnapshotDetails)["categoryId"] == categoryId) {
          //debugPrint("Join user");
          //join as user2
          transaction.update(documentReference, {
            "user2.name": name,
            "user2.uid": uid,
            "user2.profileUrl": profileUrl,
            "user2.status": true,
          });
          return false;
        }
        return true; //search for other room
      });
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  //subscribe to battle room
  Stream<DocumentSnapshot> subscribeToBattleRoomFirebase(String? battleRoomDocumentId, bool forMultiUser) {
    if (forMultiUser) {
      return _firebaseFirestore.collection(BattleRoomHelper.battleroomCollectionMulti).doc(battleRoomDocumentId).snapshots();
    } else {
      return _firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(battleRoomDocumentId).snapshots();
    }
  }

  //delete battle room
  Future<void> deleteBattleRoom(String? documentId, bool forMultiUser, {String? roomCode}) async {
    try {
      if (forMultiUser) {
        await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollectionMulti).doc(documentId).delete();
      } else {
        await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(documentId).delete();
      }

      _battleRoomStreamSubscription!.cancel();
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  //Left battle room
  Future<void> leftBattleRoomFirebase(String? documentId, bool forMultiUser, {String? roomCode, String? currentUserId}) async {
    try {
      if (forMultiUser) {
        await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollectionMulti).doc(documentId).delete();
      } else {
        if (currentUserId == battleRoomData.value!.user1?.uid) {
          if (battleRoomData.value!.user1 != null) {
            await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(documentId).set(
              {
                "user1": {"status": false},
              },
              SetOptions(merge: true),
            );
          }
        } else {
          if (battleRoomData.value!.user2 != null) {
            await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(documentId).set(
              {
                "user2": {"status": false},
              },
              SetOptions(merge: true),
            );
          }
        }
      }

      _battleRoomStreamSubscription!.cancel();
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  //Search Room
  Future<List<DocumentSnapshot>> searchBattleRoom(String categoryId) async {
    try {
      QuerySnapshot querySnapshot;
      if (await InternetConnectivity.isUserOffline()) {
        throw const SocketException("");
      }

      querySnapshot = await _firebaseFirestore
          .collection(BattleRoomHelper.battleroomCollection)
          .where("categoryId", isEqualTo: categoryId)
          .where("roomCode", isEqualTo: "")
          .where(
            "user2.uid",
            isEqualTo: "",
          )
          .get();

      return querySnapshot.docs;
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  Future<void> removeOpponentFromBattleRoomFirebase(String roomId) async {
    try {
      await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollectionMulti).doc(roomId).update({
        "user2": {"name": "", "correctAnswers": 0, "answers": [], "uid": "", "profileUrl": ""},
      });
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  //get room by roomCode (multiUserBattleRoom)
  Future<QuerySnapshot> getMultiUserBattleRoomFirebase(String? roomCode, String? type) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection(type == "battle" ? BattleRoomHelper.battleroomCollection : BattleRoomHelper.battleroomCollectionMulti).where("roomCode", isEqualTo: roomCode).get();
      return querySnapshot;
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  //delete user from multiple user room
  Future<void> updateMultiUserRoom(String? documentId, Map<String, dynamic> updatedData, String battle) async {
    try {
      _firebaseFirestore.collection(battle == "battle" ? BattleRoomHelper.battleroomCollection : BattleRoomHelper.battleroomCollectionMulti).doc(documentId).update(updatedData);
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

//submit answer To Handler

  Future saveAnswer(String? currentUserId, Map submittedAnswer, bool isCorrectAnswer, {List<BattleQuestion>? questionsList}) async {
    BattleRoomDataModel battleRoom = battleRoomData.value!;
    List<BattleQuestion>? questions = questionsList;

    //need to check submitting answer for user1 or user2
    if (currentUserId == battleRoom.user1!.uid) {
      if (battleRoom.user1!.answers.length != questions!.length) {
        submitAnswerHandle(
          battleRoomDocumentId: battleRoom.roomId,
          forUser1: true,
          submittedAnswer: List.from(battleRoom.user1!.answers)..add(submittedAnswer),
        );
      }
    } else {
      //submit answer for user2
      if (battleRoom.user2!.answers.length != questions!.length) {
        submitAnswerHandle(
          submittedAnswer: List.from(battleRoom.user2!.answers)..add(submittedAnswer),
          battleRoomDocumentId: battleRoom.roomId,
          forUser1: false,
        );
      }
    }
  }

//submit answer and update correct answer count and points
  Future<void> submitAnswerHandle({required bool forUser1, List? submittedAnswer, String? battleRoomDocumentId, int? points}) async {
    try {
      Map<String, dynamic> submitAnswer = {};
      if (forUser1) {
        submitAnswer.addAll({"user1.answers": submittedAnswer});
      } else {
        submitAnswer.addAll({"user2.answers": submittedAnswer});
      }
      await submitAnswerToFirebase(battleRoomDocumentId: battleRoomDocumentId, submitAnswer: submitAnswer, forMultiUser: false);
    } catch (e) {
      throw (e.toString());
    }
  }

//submit answer Firebase
  Future<void> submitAnswerToFirebase({required Map<String, dynamic> submitAnswer, String? battleRoomDocumentId, required bool forMultiUser}) async {
    try {
      if (forMultiUser) {
        await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollectionMulti).doc(battleRoomDocumentId).update(submitAnswer);
      } else {
        await _firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(battleRoomDocumentId).update(submitAnswer);
      }
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  // @override
  // void onClose() {
  //   _battleRoomStreamSubscription?.cancel();
  //   super.onClose();
  // }
}
