import 'dart:convert';

List<Notes> notesFromJson(String str) =>
    List<Notes>.from(json.decode(str).map((x) => Notes.fromJson(x)));

String notesToJson(List<Notes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notes {
  Notes({
    this.id,
    this.uid,
    this.category,
    this.title,
    this.body,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
    this.priority,
    this.status,
  });

  String id;
  String uid;
  String category;
  String title;
  String body;
  String createdAt;
  String updatedAt;
  String expiresAt;
  dynamic priority;
  dynamic status;

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        id: json["id"],
        uid: json["uid"],
        category: json["category"],
        title: json["title"],
        body: json["body"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        expiresAt: json["expires_at"],
        priority: json["priority"],
        status: json["status"],
      );
  factory Notes.fromNote(Notes json) => Notes(
      id: json.id,
      uid: json.uid,
      category: json.category,
      title: json.title,
      body: json.body,
      createdAt: json.category,
      updatedAt: json.updatedAt,
      expiresAt: json.expiresAt,
      priority: json.priority,
      status: json.status);

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "category": category,
        "title": title,
        "body": body,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "expires_at": expiresAt,
        "priority": priority,
        "status": status,
      };
}
