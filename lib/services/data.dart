import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/helper/jwt_decode.dart';
import 'package:notes/models/category_model.dart';
import 'package:notes/models/global.dart';
import 'package:notes/models/notes_model.dart';
import 'package:http/http.dart' as http;
import 'package:notes/models/priority_model.dart';
import 'package:notes/models/profile.dart';
import 'package:notes/models/status_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data extends ChangeNotifier {
  List<Notes> notes;
  void update() {
    notifyListeners();
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = "token";
    return prefs.remove(key);
  }

  //
  //lay thong tin user
  Future<ProfileModel> decodeToken() async {
    String token = await Data().getToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return ProfileModel.fromJson(decodedToken);
  }

  //lấy tất cả list note
  Future<List<Notes>> fetchNotes(http.Client client) async {
    String token = await Data().getToken();
    final respone = await client.get(URL_API + '/notes', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      Map<String, dynamic> mapRespone = json.decode(respone.body);
      if (mapRespone["status"] == "ok") {
        final notes = mapRespone["data"].cast<Map<String, dynamic>>();
        final listNotes = await notes.map<Notes>((json) {
          return Notes.fromJson(json);
        }).toList();
        return listNotes;
      } else {
        return [];
      }
    } else {
      throw Exception('Fail to load Notes form the Internet');
    }
  }

  //
  Future<List<Notes>> fetchData(http.Client client) async {
    String token = await Data().getToken();
    final respone = await client.get(URL_API + '/notes', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      Map<String, dynamic> mapRespone = json.decode(respone.body);
      if (mapRespone["status"] == "ok") {
        final notes = mapRespone["data"].cast<Map<String, dynamic>>();
        final listNotes = await notes.map<Notes>((json) {
          return Notes.fromJson(json);
        }).toList();
        return listNotes;
      } else {
        return [];
      }
    } else {
      throw Exception('Fail to load Notes form the Internet');
    }
  }

  // thêm note
  // String hours = now.hour < 10 ? '0${now.hour}' : '${now.hour}';
  //   String minutes = now.minute < 10 ? '0${now.minute}' : '${now.minute}';
  Future<bool> addNote(http.Client client, Map<String, dynamic> params) async {
    String token = await Data().getToken();
    final respone = await client.post(URL_API + '/note',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(params));
    if (respone.statusCode == 201) {
      final mapRespone = await json.decode(respone.body);
      if (mapRespone["status"] == "ok") {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Fail to add Notes');
    }
  }

  // update note
  Future<Notes> updateNote(
      http.Client client, Map<String, dynamic> params) async {
    String token = await Data().getToken();
    final respone = await client.put(URL_API + '/note/${params["id"]}',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(params));
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return Notes.fromJson(responeBody);
    } else {
      throw Exception('Fail to update Notes ');
    }
  }

  // lấy note theo id
  Future<Notes> fetchNoteId(http.Client client, String id) async {
    String token = await Data().getToken();
    final respone = await client.get(URL_API + '/note/$id', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      Map<String, dynamic> mapRespone = json.decode(respone.body);

      Map<String, dynamic> mapNote = mapRespone["data"];
      // mapNote.addAll(mapRespone["id"]);'
      // mapNote.addEntries(mapRespone["id"]);
      return Notes.fromJson(mapNote);
    } else {
      throw Exception('Fail to load NoteID form the Internet');
    }
  }

  // xóa note theo id
  Future<Notes> deleteNote(http.Client client, String id) async {
    String token = await Data().getToken();
    final respone = await client.delete(URL_API + '/note/$id', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return Notes.fromJson(responeBody);
    } else {
      throw Exception('Fail to delete Note');
    }
  }

  //Profile user
  //get profile
  Future<ProfileModel> getProfile(http.Client client) async {
    String token = await Data().getToken();
    final respone = await client.get(URL_API + '/userinfo', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return ProfileModel.fromJson(responeBody);
    } else {
      throw Exception('Fail to get Profile form the Internet');
    }
  }

  //update profile
  Future<ProfileModel> updateProfile(
      http.Client client, Map<String, dynamic> params) async {
    String token = await Data().getToken();
    final respone = await client.post(URL_API + '/updateprofile',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(params));
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return ProfileModel.fromJson(responeBody);
    } else {
      throw Exception('Fail to update Profile ');
    }
  }

  //
  Future<bool> addCategory(
      http.Client client, Map<String, dynamic> params) async {
    String token = await Data().getToken();
    final respone = await client.post(URL_API + '/category',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(params));
    if (respone.statusCode == 201) {
      final mapRespone = await json.decode(respone.body);
      if (mapRespone["status"] == "ok") {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Fail to add category');
    }
  }

  // add status
  Future<bool> addStatus(
      http.Client client, Map<String, dynamic> params) async {
    String token = await Data().getToken();
    final respone = await client.post(URL_API + '/status',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(params));
    if (respone.statusCode == 201) {
      final mapRespone = await json.decode(respone.body);
      if (mapRespone["status"] == "ok") {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Fail to add status');
    }
  }

  //add priority
  Future<bool> addPriority(
      http.Client client, Map<String, dynamic> params) async {
    String token = await Data().getToken();
    final respone = await client.post(URL_API + '/priority',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(params));
    if (respone.statusCode == 201) {
      final mapRespone = await json.decode(respone.body);
      if (mapRespone["status"] == "ok") {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Fail to add prioriry');
    }
  }

  //get all category
  fetchCategory(http.Client client) async {
    String token = await Data().getToken();
    final respone = await client.get(URL_API + '/categories', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      Map<String, dynamic> mapRespone = json.decode(respone.body);
      if (mapRespone["status"] == "ok") {
        final notes = mapRespone["data"].cast<Map<String, dynamic>>();
        final listCategory = await notes.map<Category>((json) {
          return Category.fromJson(json);
        }).toList();
        return listCategory;
      } else {
        return [];
      }
    } else {
      throw Exception('Fail to load');
    }
  }

  fetchPriority(http.Client client) async {
    String token = await Data().getToken();
    final respone = await client.get(URL_API + '/priority', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      Map<String, dynamic> mapRespone = json.decode(respone.body);
      if (mapRespone["status"] == "ok") {
        final notes = mapRespone["data"].cast<Map<String, dynamic>>();
        final listPriority = await notes.map<Priority>((json) {
          return Priority.fromJson(json);
        }).toList();
        return listPriority;
      } else {
        return [];
      }
    } else {
      throw Exception('Fail to load');
    }
  }

  fetchStatus(http.Client client) async {
    String token = await Data().getToken();
    final respone = await client.get(URL_API + '/status', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      Map<String, dynamic> mapRespone = json.decode(respone.body);
      if (mapRespone["status"] == "ok") {
        final notes = mapRespone["data"].cast<Map<String, dynamic>>();
        final listStatus = await notes.map<Status>((json) {
          return Status.fromJson(json);
        }).toList();
        return listStatus;
      } else {
        return [];
      }
    } else {
      throw Exception('Fail to load');
    }
  }

  //
  fetchChart(http.Client client) async {
    Map<String, double> chart;
    String token = await Data().getToken();
    final respone = await client.get(URL_API + '/count', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      chart = Map.from(json.decode(respone.body))
          .map((key, value) => MapEntry<String, double>(key, value.toDouble()));
      return chart;
    } else {
      throw Exception('Fail to load');
    }
  }

  // delete
  Future<Category> deleteCategory(http.Client client, String id) async {
    String token = await Data().getToken();
    final respone = await client.delete(URL_API + '/category/$id', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return Category.fromJson(responeBody);
    } else {
      throw Exception('Fail to delete Note');
    }
  }

  Future<Priority> deletePriority(http.Client client, String id) async {
    String token = await Data().getToken();
    final respone = await client.delete(URL_API + '/priority/$id', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return Priority.fromJson(responeBody);
    } else {
      throw Exception('Fail to delete Note');
    }
  }

  Future<Status> deleteStatus(http.Client client, String id) async {
    String token = await Data().getToken();
    final respone = await client.delete(URL_API + '/status/$id', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return Status.fromJson(responeBody);
    } else {
      throw Exception('Fail to delete Note');
    }
  }

  //update
  Future<Status> updateStatus(
      http.Client client, Map<String, dynamic> params) async {
    String token = await Data().getToken();
    final respone = await client.put(URL_API + '/note/${params["id"]}',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: params);
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return Status.fromJson(responeBody);
    } else {
      throw Exception('Fail to update Notes ');
    }
  }

  Future<Priority> updatePriority(
      http.Client client, Map<String, dynamic> params) async {
    String token = await Data().getToken();
    final respone = await client.put(URL_API + '/note/${params["id"]}',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: params);
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return Priority.fromJson(responeBody);
    } else {
      throw Exception('Fail to update Notes ');
    }
  }

  Future<Category> updateCategory(
      http.Client client, Map<String, dynamic> params) async {
    String token = await Data().getToken();
    final respone = await client.put(URL_API + '/note/${params["id"]}',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: params);
    if (respone.statusCode == 200) {
      final responeBody = await json.decode(respone.body);
      return Category.fromJson(responeBody);
    } else {
      throw Exception('Fail to update Notes ');
    }
  }
}
