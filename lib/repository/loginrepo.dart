import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginRepository {
  Future<dynamic> userLogin({
    required String email,
    required String password,
  }) async {
    Response response =
        // 192.168.0.139 is system IP address
        await http.post(Uri.parse("https://192.168.0.139:4444/users/login"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200) {
      var resjson = jsonDecode(response.body.toString());
      var user = resjson['user'];
      return user;
    } 
    if (response.statusCode == 400) {
      var resjson = jsonDecode(response.body.toString());
      var erruser = resjson['err'];
      return erruser;
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }
}
