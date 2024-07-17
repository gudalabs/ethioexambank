import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';
import '../buttons/rounded_button.dart';

class WarningAlertDialog {
  const WarningAlertDialog();

  void warningAlertDialog(BuildContext context, VoidCallback press, {String title = MyStrings.quizLeaveWarningTitle, String subTitle = ''}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: MyColor.getCardBgColor(),
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(top: Dimensions.space40, bottom: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.space10),
                    Text(
                      title.tr,
                      style: regularSmall.copyWith(color: MyColor.getTextColor(), fontSize: Dimensions.fontDefault),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    if (subTitle != '') const SizedBox(height: Dimensions.space12),
                    if (subTitle != '')
                      Text(
                        subTitle.tr,
                        style: regularSmall.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.bold, fontSize: Dimensions.fontDefault + 3),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    const SizedBox(height: Dimensions.space20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RoundedButton(
                            text: MyStrings.no.tr,
                            press: () {
                              Navigator.pop(context);
                            },
                            horizontalPadding: 3,
                            verticalPadding: 3,
                            color: MyColor.getScreenBgColor(),
                            textColor: MyColor.getTextColor(),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space10),
                        Expanded(
                          child: RoundedButton(text: MyStrings.yes.tr, press: press, horizontalPadding: 3, verticalPadding: 3, color: MyColor.getPrimaryColor(), textColor: MyColor.colorWhite),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: -30,
                left: MediaQuery.of(context).padding.left,
                right: MediaQuery.of(context).padding.right,
                child: Image.asset(
                  MyImages.warningImage,
                  height: 60,
                  width: 60,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteAccountAlertDialog(BuildContext context, VoidCallback press, {String title = MyStrings.accountDeleteSureWaring}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: MyColor.getCardBgColor(),
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(top: Dimensions.space40, bottom: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.space10),
                    Text(
                      "${MyStrings.deleteAccount.tr}?",
                      style: semiBoldLarge.copyWith(color: MyColor.getTextColor(), fontSize: Dimensions.fontDefault + 5),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const SizedBox(height: Dimensions.space15),
                    Text(
                      title.tr,
                      style: regularSmall.copyWith(color: MyColor.getTextColor(), fontSize: Dimensions.fontDefault),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const SizedBox(height: Dimensions.space20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RoundedButton(
                            text: MyStrings.cancel.tr,
                            press: () {
                              Navigator.pop(context);
                            },
                            horizontalPadding: 3,
                            verticalPadding: 3,
                            color: MyColor.getScreenBgColor(),
                            textColor: MyColor.getTextColor(),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space10),
                        Expanded(
                          child: RoundedButton(text: MyStrings.delete.tr, press: press, horizontalPadding: 3, verticalPadding: 3, color: MyColor.getPrimaryColor(), textColor: MyColor.colorWhite),
                        )
                      ],
                    ),
                
                    
                  ],
                ),
              ),
              Positioned(
                top: -30,
                left: MediaQuery.of(context).padding.left,
                right: MediaQuery.of(context).padding.right,
                child: Image.asset(
                  MyImages.crossImage,
                  height: 60,
                  width: 60,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
