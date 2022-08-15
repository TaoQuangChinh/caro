import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: controller.animation,
            child: Image.asset('assets/images/logo_caro.png'),
          ),
        ),
        const SizedBox(height: 30),
        Text("Chào mừng đến với Caro Master",
            textAlign: TextAlign.center,
            style: PrimaryStyle.bold(32, color: kPrimaryColor))
      ]),
    );
  }
}
