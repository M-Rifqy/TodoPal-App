import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    int id;
    String text;
    int completed;
    DateTime createdAt;

    Welcome({
        required this.id,
        required this.text,
        required this.completed,
        required this.createdAt,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        text: json["text"],
        completed: json["completed"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "completed": completed,
        "created_at": createdAt.toIso8601String(),
    };
}