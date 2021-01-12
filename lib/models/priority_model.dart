// To parse this JSON data, do
//
//     final priority = priorityFromJson(jsonString);

import 'dart:convert';

List<Priority> priorityFromJson(String str) =>
    List<Priority>.from(json.decode(str).map((x) => Priority.fromJson(x)));

String priorityToJson(List<Priority> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Priority {
  Priority({
    this.id,
    this.uid,
    this.priorityName,
  });

  String id;
  String uid;
  String priorityName;
  factory Priority.fromPriorityList(Priority list) =>
      Priority(id: list.id, priorityName: list.priorityName);
  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
        id: json["id"],
        uid: json["uid"],
        priorityName: json["priority_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "priority_name": priorityName,
      };
}
