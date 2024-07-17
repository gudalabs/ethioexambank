import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/screens/1vs1/play-with-friends-bottom-sheet/rooms/join-room/components/join_room_body_section.dart';
import 'package:get/get.dart';

class JoinRoomScreen extends StatelessWidget {
  const JoinRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.joinRoom.tr),
      body: const JoinRoomBodySection(),
    );
  }
}