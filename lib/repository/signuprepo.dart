import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RegisterRepo {
  Future<dynamic> userRegister({
    required String name,
    required String email,
    required int mobile,
    required String password,
    required String confirmpassword,
  }) async {
    Response response =
        await http.post(Uri.parse("https://192.168.0.139:4444/users/signup"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "name": name,
              "email": email,
              "mobile": mobile,
              "password": password,
              "confirmpassword": confirmpassword
            }));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body.toString());
      var registeruser = res['user'];
      return registeruser;
    }
    if (response.statusCode == 400) {
      var json = jsonDecode(response.body.toString());
      var errreguser = json['error'];
      return errreguser;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
