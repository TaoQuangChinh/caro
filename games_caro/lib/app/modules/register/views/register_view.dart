import 'package:flutter/material.dart';
import 'package:games_caro/app/modules/register/views/body/body_register.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyRegister(controller: controller),
    );
  }
}
