// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.uid,
    this.categoryName,
  });

  String id;
  String uid;
  String categoryName;
  factory Category.fromCateList(Category list) =>
      Category(id: list.id, categoryName: list.categoryName);
  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        uid: json["uid"],
        categoryName: json["cate_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "cate_name": categoryName,
      };
}
