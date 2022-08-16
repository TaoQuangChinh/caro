import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';

class CustomImageLoading extends StatelessWidget {
  const CustomImageLoading(
      {Key? key, required this.animation, this.height = 50, this.width = 50})
      : super(key: key);

  final Animation<double> animation;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: CircleAvatar(
            backgroundColor: kGreyColor400,
            radius: 80,
            child: Text("Zzz...",
                style: PrimaryStyle.normal(13, color: Colors.white))),
      ),
    );
  }
}
