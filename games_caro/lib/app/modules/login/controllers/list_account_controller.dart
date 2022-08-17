import 'package:flutter/material.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:games_caro/app/modules/auth/auth_controller.dart';
import 'package:games_caro/app/modules/login/views/body/body_bottom_sheet.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:games_caro/app/utils/utils.dart';
import 'package:games_caro/app/widget/body/change_pass_view.dart';
import 'package:get/get.dart';

class ListAccountController extends GetxController
    with GetTickerProviderStateMixin {
  final isLoading = false.obs;
  final isLoadingChange = false.obs;
  final listAccount = <UserModel>[].obs;
  final listErrChange = ["", ""].obs;

  final AuthController authController = Get.find();
  late final AnimationController _aniController =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: false);
  late final Animation<double> animation =
      CurvedAnimation(parent: _aniController, curve: Curves.slowMiddle);

  TextEditingController inputPassNew = TextEditingController();
  TextEditingController inputConfirmPass = TextEditingController();

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
    _aniController.dispose();
    super.onClose();
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

  void initData() async {
    await getListAccount();
  }

  Future<void> getListAccount() async {
    isLoading.value = true;
    final res = await api.get('$kUrl/list-account');
    isLoading.value = false;

    if (res.statusCode == 200 && res.data['code'] == 0) {
      final convertList = res.data['payload'] as List;
      listAccount.value =
          convertList.map((data) => UserModel.fromJson(data)).toList();
      update();
    }
  }

  void showBottomSheet(UserModel user) {
    if (user.saveAccount == '1') {
      authController.user.value = user;
      Get.offNamed(Routes.HOME);
      return;
    }
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: Get.context!,
        constraints: const BoxConstraints(maxHeight: 140),
        builder: (context) {
          return BodyBottomSheet(
            removeAccount: () {},
            user: user,
            changePass: () => Utils.showMessPopup(content: 'Chúng tôi đã gửi'),
          );
        });
  }

  // changePass: () {
  //             Get.back();
  //             clearDataChange();
  //             Utils.showDialogDefault(
  //                 body: GetBuilder<ListAccountController>(builder: (_) {
  //               return Obx(() => ChangePassView(
  //                   controller: [inputPassNew, inputConfirmPass],
  //                   textError: _.listErrChange,
  //                   isLoading: isLoadingChange.value,
  //                   submit: () async => await handleChangePass(user.id!)));
  //             }));
  //           }

  Future<void> handleChangePass(String id) async {
    if (!validatorChange) return;
    final form = {"id": id, "pass_confirm": inputConfirmPass.text};
    isLoadingChange(true);
    final res = await api.post('$kUrl/change-pass', data: form);
    isLoadingChange(false);

    if (res.statusCode == 200 && res.data['code'] == 0) {
      Get.back();
      clearDataChange();
    } else {
      print('Err ${res.data['message']}');
    }
  }

  void clearDataChange() {
    inputPassNew.clear();
    inputConfirmPass.clear();
    listErrChange.value = ["", ""];
    isLoadingChange(false);
  }
}
