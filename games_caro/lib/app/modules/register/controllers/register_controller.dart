import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/modules/auth/auth_controller.dart';
import 'package:games_caro/app/modules/register/views/body/body_bottom_sheet.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputNameGame = TextEditingController();

  final isLoadImage = false.obs;
  final isLoading = false.obs;
  final listError = ["", ""].obs;
  var _modelInfo = '';

  final DeviceInfoPlugin _device = DeviceInfoPlugin();
  final uuid = Uuid();
  final fileImage = File("").obs;
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
    inputEmail.dispose();
    inputNameGame.dispose();
    super.onClose();
  }

  void initData() {
    getModel();
  }

  bool validator() {
    var result = true;
    listError.value = ["", ""];
    if (inputNameGame.text.trim().isEmpty) {
      listError[0] = "vui lòng không để trống thông tin";
      result = false;
    } else if (inputNameGame.text.length > 10) {
      listError[0] = "nick name không quá 10 ký tự";
      result = false;
    }
    if (inputEmail.text.trim().isEmpty) {
      listError[1] = "vui lòng không để trống thông tin";
      result = false;
    } else if (!inputEmail.text.trim().isEmail) {
      listError[1] = "địa chỉ email không hợp lệ";
      result = false;
    }
    update();
    return result;
  }

  void getModel() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await _device.androidInfo;
      //print(android.model);
      _modelInfo = "${android.model}";
    } else if (Platform.isIOS) {
      IosDeviceInfo ios = await _device.iosInfo;
      //print(ios.utsname.machine);
      _modelInfo = "${ios.model}";
    }
  }

  Future<void> submit() async {
    if (!validator()) return;
    final uui = uuid.v4();
    isLoading.value = true;
    if (fileImage.value.path != '') {
      await handleAddImageToStore(uui);
    } else {
      await registerAccount(uui);
    }
  }

  void clearData() {
    inputEmail.clear();
    inputNameGame.clear();
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
      print('Image error: $err');
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse res = await ImagePicker().retrieveLostData();
    if (res.isEmpty) return;
    if (res.file != null) {
      fileImage.value = File(res.file!.path);
    } else {
      print(res.exception!.code);
    }
    update();
  }

  Future<void> handleAddImageToStore(id) async {
    Reference ref = authController.storage
        .refFromURL('gs://app-caro-776ce.appspot.com/')
        .child(id);
    UploadTask task = ref.putFile(fileImage.value);
    task.then((snapshot) {
      snapshot.ref
          .getDownloadURL()
          .then((value) async => await registerAccount(id, urlImage: value));
    }).catchError((err) {
      print("Có một lỗi xảy ra trong quá trình lưu file.");
      print("Storage: $err");
      isLoading.value = false;
    });
  }

  Future<void> registerAccount(id, {String urlImage = ''}) async {
    final form = {
      "id": id,
      "email": inputEmail.text,
      "nameGame": inputNameGame.text,
      "deviceMobi": _modelInfo,
      "images": urlImage
    };
    final res = await api.post('$kUrl/register', data: form);
    isLoading.value = false;
    if (res.statusCode == 200 && res.data['code'] == 0) {
      clearData();
      Get.offNamed(Routes.LOGIN);
    } else {
      print("Erro: ${res.data['message']}");
    }
    update();
  }
}
