import 'package:flutter/material.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/screens/1vs1/play-with-friends-bottom-sheet/rooms/create-room/create-room-body-section/create_room_body_section.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/my_strings.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: CustomCategoryAppBar(title: MyStrings.createRoom.tr),
        body: const CreateRoomBodySection());
  }
}
