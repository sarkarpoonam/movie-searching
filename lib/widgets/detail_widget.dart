import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class MovieDetailWidget extends StatelessWidget {
  final String detail, value;
  const MovieDetailWidget({
    Key? key,
    required this.detail,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          detail,
          style: TextStyle(color: ThemeColor.white, fontSize: 17),
        ),

        Text(
          value,
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ],
    );
  }
}