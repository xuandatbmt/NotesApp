import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/models/global.dart';
import 'package:notes/models/notes_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Data extends ChangeNotifier {
  List<Notes> notes;

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
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

  // thêm note
  // String hours = now.hour < 10 ? '0${now.hour}' : '${now.hour}';
  //   String minutes = now.minute < 10 ? '0${now.minute}' : '${now.minute}';
  // Future<List<Notes>> addNote(http.Client client) async {
  //   String token = await Data().getToken();
  //   final respone = await client.post(URL_API + '/note', headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': 'Bearer $token',
  //   });
  //   if (respone.statusCode == 200) {
  //     Map<String, dynamic> mapRespone = json.decode(respone.body);
  //     if (mapRespone["status"] == "ok") {
  //       final notes = mapRespone["data"].cast<Map<String, dynamic>>();
  //       final listNotes = await notes.map<Notes>((json) {
  //         return Notes.fromJson(json);
  //       }).toList();
  //       return listNotes;
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     throw Exception('Fail to load Notes form the Internet');
  //   }
  // }
  // update note
  Future<Notes> updateNote(
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
      return Notes.fromJson(responeBody);
    } else {
      throw Exception('Fail to load Notes form the Internet');
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
      if (mapRespone["status"] == "ok") {
        Map<String, dynamic> mapNote = mapRespone["data"];
        return Notes.fromJson(mapNote);
      } else {
        return Notes();
      }
    } else {
      throw Exception('Fail to load Notes form the Internet');
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
      throw Exception('Fail to load Notes form the Internet');
    }
  }
}
