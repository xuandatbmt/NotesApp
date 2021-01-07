// To parse this JSON data, do
//
//     final status = statusFromJson(jsonString);

import 'dart:convert';

List<Status> statusFromJson(String str) =>
    List<Status>.from(json.decode(str).map((x) => Status.fromJson(x)));

String statusToJson(List<Status> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Status {
  Status({
    this.id,
    this.uid,
    this.statusName,
  });

  String id;
  String uid;
  String statusName;
  factory Status.fromStatusList(Status list) =>
      Status(statusName: list.statusName);
  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        uid: json["uid"],
        statusName: json["status_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "status_name": statusName,
      };
}
