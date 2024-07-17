import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/utils/my_color.dart';
import '../../../components/app-bar/custom_appbar.dart';
import 'coin_store_webview_widget.dart';



class CoinStroreWebViewScreen extends StatefulWidget {

  final String redirectUrl;

  const CoinStroreWebViewScreen({
    Key? key,
    required this.redirectUrl
  }) : super(key: key);


  @override
  State<CoinStroreWebViewScreen> createState() => _CoinStroreWebViewScreenState();
}

class _CoinStroreWebViewScreenState extends State<CoinStroreWebViewScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: '',isShowBackBtn: true,),
      body: CoinStroreWebViewWidget(url: widget.redirectUrl),
      floatingActionButton: favoriteButton(),
    );
  }


  Widget favoriteButton() {
    return FloatingActionButton(
      backgroundColor: MyColor.colorRed,
      onPressed: () async {
        Get.back();
      },
      child: const Icon(Icons.cancel,color: MyColor.colorWhite,size: 30,),
    );
  }


  Future<Map<Permission, PermissionStatus>> permissionServices() async{

    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.microphone,
      Permission.mediaLibrary,
      Permission.camera,
      Permission.storage,
    ].request();

    return statuses;
  }

}

