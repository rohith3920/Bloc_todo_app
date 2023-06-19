import 'dart:convert';

import 'package:client/model/todomodel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GettodoRepo {
  Future<List<GettodoModel>> Gettodos() async {
    Response response =
        await http.get(Uri.parse("https://192.168.0.139:4444/todos"));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
    
      return result.map((e) => GettodoModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}


