import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/model/todomodel.dart';
import 'package:http/http.dart';

class PosttodoRepo {
  Future<PosttodoModel> Posttodos({required String task}) async {
    Response response =
        await http.post(Uri.parse("https://192.168.0.139:4444/todos"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({"task": task}));

    if (response.statusCode == 201) {
      var result = jsonDecode(response.body.toString());
      return PosttodoModel.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
