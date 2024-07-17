import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/view/components/image_widget/my_image_widget.dart';

import '../../../../../../core/utils/url_container.dart';


class PlayerProfilePicture extends StatelessWidget {
  final String imagePath;
  const PlayerProfilePicture({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.space2),
      height: MediaQuery.of(context).size.width / 5,
      width: MediaQuery.of(context).size.width / 5,
      decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
      child: FittedBox(
        fit: BoxFit.cover,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.space100),
            child: imagePath.toString() == "null"
                ? Image.asset(
                    MyImages.defaultAvatar,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 5,
                    width: MediaQuery.of(context).size.width / 5,
                  )
                : MyImageWidget(
                    fromProfile: true,
                    imageUrl:"${UrlContainer.userImagePath}/$imagePath",
                    height: MediaQuery.of(context).size.width / 5,
                    width: MediaQuery.of(context).size.width / 5,
                  )),
      ),
    );
  }
}
