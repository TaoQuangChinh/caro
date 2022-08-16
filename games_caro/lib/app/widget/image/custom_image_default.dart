import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';

class CustomImageDefault extends StatelessWidget {
  const CustomImageDefault(
      {Key? key,
      required this.content,
      this.height = 50,
      this.width = 50,
      this.backgroundColor = kBlackColor900,
      this.textColor = kWhiteColor})
      : super(key: key);

  final String content;
  final double? height, width;
  final Color? backgroundColor, textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: 80,
        child: Text(content.toUpperCase(),
            style: PrimaryStyle.bold(20, color: textColor)),
      ),
    );
  }
}
