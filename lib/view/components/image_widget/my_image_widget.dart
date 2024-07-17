import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';

class MyImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double radius;
  final BoxFit boxFit;
  final bool fromProfile;
  final bool fromCoin;
  const MyImageWidget({
    super.key,
    required this.imageUrl,
    this.height = 80,
    this.width = 100,
    this.radius = 5,
    this.fromProfile = false,
    this.fromCoin = false,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl.toString(),
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(image: imageProvider, fit: boxFit),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.defaultRadius * 5),
            child: Center(
              child: SpinKitFadingCube(
                color: MyColor.primaryColor.withOpacity(0.3),
                size: Dimensions.space20,
              ),
            )),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: height,
        width: width,
        child:  fromCoin?
        SvgPicture.asset(
          MyImages.coin,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ) :ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.defaultRadius * 5),
          child: Center(
            child:

            fromProfile?
            Image.asset(
              MyImages.defaultAvatar,
              fit: BoxFit.cover,
            ) :
            Icon(
              Icons.image,
              color: MyColor.colorGrey.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
