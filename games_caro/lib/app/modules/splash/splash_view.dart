import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/modules/auth/auth_controller.dart';

import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: false);
  late final Animation<double> animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint);
  final AuthController authController = Get.find();

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: animation,
            child: Image.asset('assets/images/logo.png', height: 300),
          ),
        ),
        const SizedBox(height: 30),
        Text("Spending Management",
            textAlign: TextAlign.center,
            style: PrimaryStyle.bold(32, color: kPrimaryColor))
      ]),
    );
  }

  void initData() async {
    await authController.checkDevice();
  }
}
