// To parse this JSON data, do
//
//     final status = statusFromJson(jsonString);

import 'dart:convert';

List<Chart> chartFromJson(String str) =>
    List<Chart>.from(json.decode(str).map((x) => Chart.fromJson(x)));

String chartFromJsonToJson(List<Chart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chart {
  Chart({this.name, this.value});

  String name;
  int value;

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
