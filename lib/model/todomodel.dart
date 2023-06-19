import 'package:meta/meta.dart';
import 'dart:convert';

class GettodoModel {
  final String id;
  final String task;
  final int v;

  GettodoModel({
    required this.id,
    required this.task,
    required this.v,
  });

  factory GettodoModel.fromJson(Map<String, dynamic> json) => GettodoModel(
        id: json["_id"],
        task: json["task"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "task": task,
        "__v": v,
      };
}
// ---------------------------------------------------------------------------------------------------------------------------------------

List<PosttodoModel> posttodoModelFromJson(String str) => List<PosttodoModel>.from(json.decode(str).map((x) => PosttodoModel.fromJson(x)));

String posttodoModelToJson(List<PosttodoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PosttodoModel {
    final String id;
    final String task;
    final int v;

    PosttodoModel({
        required this.id,
        required this.task,
        required this.v,
    });

    factory PosttodoModel.fromJson(Map<String, dynamic> json) => PosttodoModel(
        id: json["_id"],
        task: json["task"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "task": task,
        "__v": v,
    };
}
