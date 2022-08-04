import 'package:get/get_connect.dart';

class ApiProvider extends GetConnect {
  Future<dynamic> posts(data) async {
    return post('http://localhost:300/login', data);
  }

  Future<dynamic> gets() async {
    return get('http://localhost:300/');
  }
}
