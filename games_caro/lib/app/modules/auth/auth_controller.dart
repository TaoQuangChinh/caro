import 'package:firebase_storage/firebase_storage.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final authDevice = ''.obs;
  final user = UserModel().obs;
  late FirebaseStorage storage;

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

  void initData() async {
    storage = FirebaseStorage.instance;
  }
}
