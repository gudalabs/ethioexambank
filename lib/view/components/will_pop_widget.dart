import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/view/components/dialog/exit_dialog.dart';

class WillPopWidget extends StatelessWidget {
  final Widget child;
  final String nextRoute;
  final bool fromBottomNav;

  const WillPopWidget({Key? key, this.fromBottomNav = false, required this.child, this.nextRoute = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (nextRoute.isEmpty) {
            showExitDialog(context);
            return Future.value(false);
          } else {
            if(fromBottomNav){
              Get.offAllNamed(RouteHelper.bottomNavBarScreen);
              return Future.value(true);
            } else{
              Get.offAndToNamed(nextRoute);
              return Future.value(false);
            }


          }
        },
        child: child);
  }
}
