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

  final isLoading = false.obs;
  final listError = ["", ""].obs;
  var _modelInfo = '';

  final DeviceInfoPlugin _device = DeviceInfoPlugin();
  final uuid = Uuid();
  final fileImage = File("").obs;
  late FirebaseStorage _storage;
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
    _storage = FirebaseStorage.instance;
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
    final form = <String, dynamic>{
      "id": uuid.v4(),
      "email": inputEmail.text,
      "nameGame": inputNameGame.text,
      "deviceMobi": _modelInfo
    };
    isLoading.value = true;
    final res = await api.post('$kUrl/register', data: form);
    isLoading.value = false;
    if (res.statusCode == 200 && res.data['code'] == 0) {
      clearData();
      Get.toNamed(Routes.LOGIN);
    } else {
      print("Erro: ${res.data['message']}");
    }
    update();
  }

  void clearData() {
    inputEmail.clear();
    inputNameGame.clear();
    update();
  }

  Future<void> showModalSheet() async {
    showModalBottomSheet(
        context: Get.context!,
        constraints: const BoxConstraints(maxHeight: 103),
        builder: (context) {
          return BodyBottomSheet(
              imageCamera: () => handlePickerImage(ImageSource.camera),
              pickerImage: () => handlePickerImage(ImageSource.gallery));
        });
  }

  Future<void> handlePickerImage(ImageSource source) async {
    Get.back();
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        fileImage.value = File(image.path);
        await handleAddImageToStore();
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

  Future<void> handleAddImageToStore() async {
    Reference ref = await _storage
        .refFromURL('gs://app-caro-776ce.appspot.com/')
        .child('user');
    UploadTask task = ref.putFile(fileImage.value);
    task.then((snapshot) {
      snapshot.ref.getDownloadURL().then((value) => print("dowload: $value"));
    }).catchError((err) {
      print("Storage: $err");
    });
  }
}
