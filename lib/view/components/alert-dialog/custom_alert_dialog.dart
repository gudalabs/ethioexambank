import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';

class CustomAlertDialog {
  bool isHorizontalPadding;
  final Widget child;
  final bool barrierDismissible;
  final bool willPop;
  final double borderRadius;

  CustomAlertDialog({
    this.isHorizontalPadding = false,
    required this.child,
    this.barrierDismissible = true,
    this.willPop = true,
    this.borderRadius = 10,
  });

  void customAlertDialog(BuildContext context) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) => WillPopScope(
              onWillPop: () async {
                return willPop;
              },
              child: Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    padding: isHorizontalPadding ? const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space12) : const EdgeInsets.symmetric(vertical: Dimensions.space15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(borderRadius)),
                    child: child,
                  ),
                ),
              ),
            ));
  }
}
