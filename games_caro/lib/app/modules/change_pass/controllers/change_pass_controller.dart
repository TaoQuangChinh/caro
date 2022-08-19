import 'package:flutter/material.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/modules/change_pass/views/change_pass_screen.dart';
import 'package:games_caro/app/utils/utils.dart';
import 'package:get/get.dart';

class ChangePassController extends GetxController {
  TextEditingController inputVerifiCode = TextEditingController();
  TextEditingController inputPassNew = TextEditingController();
  TextEditingController inputConfirmPass = TextEditingController();

  var _code = '';
  var _email = '';
  final stringError = ''.obs;
  final loadingSubmit = false.obs;
  final loadingSendCode = false.obs;
  final loadingChange = false.obs;
  final listErrChange = ["", ""].obs;
  final reg =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  void onInit() {
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

  bool get validator {
    var result = true;
    if (inputVerifiCode.text.trim().isEmpty) {
      stringError.value = 'vui lòng không để trống thông tin';
      result = false;
    } else if (inputVerifiCode.text != _code) {
      stringError.value = 'mã xác thực không đúng';
      result = false;
    }
    update();
    return result;
  }

  bool get validatorChange {
    var result = true;
    listErrChange.value = ["", ""];
    if (inputPassNew.text.trim().isEmpty) {
      listErrChange[0] = 'thông tin không được để trống';
      result = false;
    } else if (inputPassNew.text.length > 100) {
      listErrChange[0] = 'mật khẩu không quá 100 ký tự';
      result = false;
    } else if (!reg.hasMatch(inputPassNew.text)) {
      Utils.messWarning(MSG_FORMAT_PASS);
      result = false;
    }
    if (inputConfirmPass.text.trim().isEmpty) {
      listErrChange[1] = 'thông tin không được để trống';
      result = false;
    } else if (inputConfirmPass.text != inputPassNew.text) {
      listErrChange[1] = 'mật khẩu không giống nhau';
      result = false;
    }
    update();
    return result;
  }

  Future<void> handleSendVerifiCode(String email) async {
    final form = {'email': email};

    loadingSendCode(true);
    final res = await api.post('$kUrl/send-code', data: form);
    loadingSendCode(false);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      _code = res.data['payload']['verifi_code'];
      Utils.messSuccess(res.data['message']);
    } else {
      Utils.messError(res.data['message']);
    }
    update();
  }

  void clearDataVerifiCode() {
    inputVerifiCode.clear();
    stringError.value = '';
    update();
  }

  void submitVerifiCode(String email) {
    if (!validator) return;
    Get.back();
    _email = email;
    clearDataChange();
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: const ChangePassScreen(),
          );
        });
  }

  Future<void> handleChangePass() async {
    if (!validatorChange) return;
    final form = {"email": _email, "pass_confirm": inputConfirmPass.text};
    loadingChange(true);
    final res = await api.put('$kUrl/change-pass', data: form);
    loadingChange(false);

    if (res.statusCode == 200 && res.data['code'] == 0) {
      Get.back();
      Utils.messSuccess(res.data['message']);
    } else {
      Utils.messError(res.data['message']);
    }
    update();
  }

  void clearDataChange() {
    inputPassNew.clear();
    inputConfirmPass.clear();
    listErrChange.value = ["", ""];
    loadingChange(false);
    _code = '';
    update();
  }
}
