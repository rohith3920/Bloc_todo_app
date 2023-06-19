import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/model/todomodel.dart';
import 'package:http/http.dart';

class DeletetodoRepo {
  Future<PosttodoModel> Deletetodos({required String id}) async {
    Response response =
        await http.delete(Uri.parse("https://192.168.0.139:4444/todos/$id"),
            headers: {
              'Content-Type': 'application/json',
            });

    if (response.statusCode == 201) {
      var result = jsonDecode(response.body.toString());
      return PosttodoModel.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
