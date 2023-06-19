import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/model/todomodel.dart';
import 'package:http/http.dart';

class UpdatetodoRepo {
  Future<PosttodoModel> Updatetodos({required String task,required String id}) async {
    Response response =
        await http.patch(Uri.parse("https://192.168.0.139:4444/todos/$id"),
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
