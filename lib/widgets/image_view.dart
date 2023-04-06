import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ImageView extends StatelessWidget {
  double height = 0;
  double width = 0;
  String? url = "";
  String? placeHolder;
  BoxFit fit;
  File? file;
  bool male;

  ImageView(
      {Key? key,
        this.height = 0,
        this.width = 0,
        this.url = "",
        this.placeHolder,
        this.fit = BoxFit.cover,
        this.file,
        this.male = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (file != null) {
      if (height > 0 && width > 0) {
        return Image.file(
          file!,
          height: height,
          width: width,
          fit: fit,
        );
      } else {
        return Image.file(
          file!,
          fit: BoxFit.fill,
        );
      }
    } else if (url!.isNotEmpty) {
      if (height > 0 && width > 0) {
        return CachedNetworkImage(
          imageUrl: url!,
          fit: fit,
          width: width,
          height: height,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: url!,
          fit: fit,
        );
      }
    } else {
      String? dynamicPlaceHolder = placeHolder ??
          (male ? "" : "");
      if (height > 0 && width > 0) {
        return Image.asset(dynamicPlaceHolder,
            height: height, width: width, fit: fit);
      } else {
        return Image.asset(dynamicPlaceHolder, fit: fit);
      }
    }
  }
}
