import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/widget/button/primary_button.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading(
      {Key? key,
      required this.isLoading,
      required this.titleButton,
      required this.onPressed,
      this.height = 10,
      this.width = 10,
      this.sizeContent = 16,
      this.colors = kPrimaryColor})
      : super(key: key);

  final bool isLoading;
  final String titleButton;
  final Function()? onPressed;
  final double height, width;
  final double sizeContent;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: colors));
    }
    return SizedBox(
      height: height,
      width: width,
      child: PrimaryButton(
          sizeContent: sizeContent,
          colors: colors,
          content: titleButton,
          onPressed: onPressed),
    );
  }

  Widget abc() {
    return PrimaryButton(
        colors: kPrimaryColor, content: titleButton, onPressed: onPressed);
  }
}
