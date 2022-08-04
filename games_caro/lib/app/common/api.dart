import 'package:get/get_connect.dart';

class ApiProvider extends GetConnect {
  Future<Response<dynamic>> posts(ulrs, data) async {
    return post('http://localhost:300' + ulrs, data);
  }

  Future<dynamic> gets() async {
    return await get('http://localhost:300/');
  }
}
