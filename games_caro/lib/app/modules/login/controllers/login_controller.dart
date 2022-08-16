import 'package:flutter/material.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:games_caro/app/modules/auth/auth_controller.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:games_caro/app/utils/utils.dart';
import 'package:games_caro/app/widget/body/change_pass_view.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPass = TextEditingController();
  TextEditingController inputPassNew = TextEditingController();
  TextEditingController inputConfirmPass = TextEditingController();

  final isLoadingLogin = false.obs;
  final isLoadingChange = false.obs;
  final listErrLogin = ["", ""].obs;
  final listErrChange = ["", ""].obs;
  final isSaveAccount = false.obs;

  final AuthController authController = Get.find();

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initData() {
    if (Get.parameters['screen'] == 'listAccount') {
      inputEmail.text = '${Get.parameters['email']}';
    }
  }

  bool get validatorLogin {
    var result = true;
    listErrLogin.value = ["", ""];
    if (inputEmail.text.isEmpty) {
      listErrLogin[0] = 'thông tin không được để trống';
      result = false;
    } else if (!inputEmail.text.isEmail) {
      listErrLogin[0] = 'email không đúng định dạng';
      result = false;
    }
    if (inputPass.text.isEmpty) {
      listErrLogin[1] = 'mật khẩu không được để trống';
      result = false;
    } else if (inputPass.text.length > 50) {
      listErrLogin[1] = 'mật khẩu không lớn quá 8 kí tự';
      result = false;
    }
    return result;
  }

  bool get validatorChange {
    var result = true;
    listErrChange.value = ["", ""];
    if (inputPassNew.text.isEmpty) {
      listErrChange[0] = 'thông tin không được để trống';
      result = false;
    } else if (inputPassNew.text.length > 50) {
      listErrChange[0] = 'mật khẩu không quá 50 ký tự';
      result = false;
    }
    if (inputConfirmPass.text.isEmpty) {
      listErrChange[1] = 'thông tin không được để trống';
      result = false;
    } else if (!inputConfirmPass.text.contains(inputPassNew.text)) {
      listErrChange[1] = 'mật khẩu không giống nhau';
      result = false;
    }
    update();
    return result;
  }

  Future<void> submit() async {
    if (!validatorLogin) return;
    final form = {
      "email": inputEmail.text,
      "pass": inputPass.text,
      "save_acc": isSaveAccount.value
    };
    isLoadingLogin.value = true;
    final res = await api.post('$kUrl/login', data: form);
    isLoadingLogin.value = false;

    if (res.statusCode == 200 && res.data['code'] == 0) {
      authController.user.value = UserModel.fromJson(res.data['payload']);
      clearDataChange();
      Utils.showDialogDefault(body: GetBuilder<LoginController>(builder: (_) {
        return Obx(() => ChangePassView(
            controller: [inputPassNew, inputConfirmPass],
            textError: _.listErrChange,
            isLoading: isLoadingChange.value,
            submit: () async => await handleChangePass()));
      }));
    } else {
      print(res.data['message']);
    }
  }

  Future<void> handleChangePass() async {
    if (!validatorChange) return;
    final form = {
      "email": inputEmail.text,
      "pass_confirm": inputConfirmPass.text
    };
    isLoadingChange(true);
    final res = await api.post('$kUrl/change-pass', data: form);
    isLoadingChange(false);

    if (res.statusCode == 200 && res.data['code'] == 0) {
      Get.back();
      clearDataLogin();
      clearDataChange();
      Get.offAllNamed(Routes.HOME);
    } else {
      print('Err ${res.data['message']}');
    }
  }

  void clearDataLogin() {
    inputEmail.clear();
    inputPass.clear();
  }

  void clearDataChange() {
    inputPassNew.clear();
    inputConfirmPass.clear();
    listErrChange.value = ["", ""];
    isLoadingChange(false);
  }

  void handleSavePass(value) {
    isSaveAccount(value);
  }
}
