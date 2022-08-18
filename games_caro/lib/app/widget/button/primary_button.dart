import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.content,
      required this.onPressed,
      this.colors = kIndigoBlueColor900,
      this.sizeContent = 12})
      : super(key: key);

  final Function()? onPressed;
  final Color? colors;
  final String content;
  final double sizeContent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: colors,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: onPressed,
        child: Text(
          content,
          style: PrimaryStyle.medium(sizeContent),
        ));
  }
}
