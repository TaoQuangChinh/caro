import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/modules/auth/auth_controller.dart';
import 'package:games_caro/app/modules/register/views/body/body_bottom_sheet.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:games_caro/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class RegisterController extends GetxController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputCode = TextEditingController();

  final isLoadImage = false.obs;
  final isLoading = false.obs;
  final listError = ["", ""].obs;

  final _log = Logger();
  final fileImage = File("").obs;
  final AuthController authController = Get.find();

  String? _urlImage;

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
    inputEmail.dispose();
    inputCode.dispose();
    super.onClose();
  }

  bool validator() {
    var result = true;
    listError.value = ["", ""];
    if (inputCode.text.trim().isEmpty) {
      listError[0] = "vui lòng không để trống thông tin";
      result = false;
    }
    if (inputEmail.text.trim().isEmpty) {
      listError[1] = "vui lòng không để trống thông tin";
      result = false;
    } else if (!inputEmail.text.isEmail) {
      listError[1] = "địa chỉ email không hợp lệ";
      result = false;
    }
    update();
    return result;
  }

  Future<void> submit() async {
    if (!validator()) return;
    isLoading.value = true;
    if (fileImage.value.path != '') {
      await handleAddImageToStore();
      if (!['', null].contains(_urlImage)) await registerAccount();
    } else {
      await registerAccount();
    }
  }

  void clearData() {
    inputEmail.clear();
    inputCode.clear();
    _urlImage = null;
    fileImage.value = File('');
    update();
  }

  Future<void> showModalSheet() async {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: Get.context!,
        constraints: const BoxConstraints(maxHeight: 148),
        builder: (context) {
          return BodyBottomSheet(
              imageCamera: () => handlePickerImage(ImageSource.camera),
              pickerImage: () => handlePickerImage(ImageSource.gallery),
              removeAvatar: () {
                Get.back();
                _urlImage = null;
                if (fileImage.value.path != '') fileImage.value = File('');
              });
        });
  }

  Future<void> handlePickerImage(ImageSource source) async {
    Get.back();
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        fileImage.value = File(image.path);
      }
      update();
    } on PlatformException catch (err) {
      _log.e("Image: $err");
      Utils.messWarning(MSG_SYSTEM_HANDLE);
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse res = await ImagePicker().retrieveLostData();
    if (res.isEmpty) return;
    if (res.file != null) {
      fileImage.value = File(res.file!.path);
    } else {
      _log.e("Image(retrieveLostData): ${res.exception!.code}");
      Utils.messWarning(MSG_SYSTEM_HANDLE);
    }
    update();
  }

  Future<void> handleAddImageToStore() async {
    try {
      Reference ref = authController.storage
          .refFromURL('gs://app-caro-776ce.appspot.com/')
          .child(inputCode.text);
      UploadTask task = ref.putFile(fileImage.value);
      _urlImage = await task.snapshot.ref.getDownloadURL();
    } catch (err) {
      isLoading.value = false;
      _log.e('Fire Store: $err');
      Utils.messWarning(MSG_SAVE_FILE);
    }
  }

  Future<void> registerAccount() async {
    final form = {
      "id": inputCode.text,
      "email": inputEmail.text,
      "images": _urlImage
    };
    final res = await api.post('/register', data: form);
    isLoading.value = false;
    if (res.statusCode == 200 && res.data['code'] == 0) {
      clearData();
      if (Get.parameters['screen'] == 'listAccount') {
        Get.offNamed(Routes.LOGIN, parameters: {'screen': 'register'});
        return;
      }
      Utils.messSuccess(res.data['message']);
    } else {
      Utils.messError(res.data['message']);
    }
    update();
  }
}
