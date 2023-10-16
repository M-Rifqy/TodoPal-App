import 'dart:convert';

TodoPalModel todoPalModelFromJson(String str) => TodoPalModel.fromJson(json.decode(str));

String todoPalModelToJson(TodoPalModel data) => json.encode(data.toJson());

class TodoPalModel {
    int? id;
    String? text;
    int? completed;
    DateTime? createdAt;

    TodoPalModel({
        required this.id,
        required this.text,
        required this.completed,
        required this.createdAt,
    });

    factory TodoPalModel.fromJson(Map<String, dynamic> json) => TodoPalModel(
        id: json["id"],
        text: json["text"],
        completed: json["completed"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "completed": completed,
        "created_at": createdAt!.toIso8601String(),
    };
}