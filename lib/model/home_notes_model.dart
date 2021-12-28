import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:note_app_task/json/interest_json.dart';
import 'package:note_app_task/json/note_home_json.dart';
import 'package:note_app_task/json/user_json.dart';
import 'package:note_app_task/utils/env.dart';

class NoteModel with ChangeNotifier {
  String? _valueDropdon;

  String? get getvalueDropdon => _valueDropdon;

  void setvalueDropdon(String value) {
    _valueDropdon = value;
    notifyListeners();
  }

  Future<List<User>> loadUser(BuildContext context) async {
    var url = Uri.parse('$baseUrl/users/getall');
    var response = await http.get(url, headers: {
      'content-type': 'multipart/form-data',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $token',
    });
    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      throw Exception('Failed to load Note');
    }
  }

  Future<List<Notes>> loadNotes(BuildContext context) async {
    var url = Uri.parse('$baseUrl/notes/getall');

    http.Response response = await http.get(url, headers: {
      'content-type': 'multipart/form-data',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $token',
    });

    dynamic responseDecoded = json.decode(response.body);
    // if (response.statusCode == 200) {
    if (response.statusCode == 200) {
      return notesFromJson(response.body);
    } else {
      throw Exception('Failed to load Note');
    }
  }

  Future updateNotes({
    required BuildContext context,
    String? id,
    String? textEdite,
    String? userID,
    String? dateTimeID,
  }) async {
    var url = Uri.parse('$baseUrl/notes/update');

    http.post(url,
        body: json.encode({
          "Id": id,
          "Text": textEdite,
          "UserId": userID,
          "PlaceDateTime": "2021-11-18T09:39:44"
        }),
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        }).then((http.Response response) {
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Nots is updated"),
        ));
      }
    });
  }

  Future addNotes({
    required BuildContext context,
    String? textAdd,
    String? dateTimeID,
  }) async {
    var url = Uri.parse('$baseUrl/notes/insert');

    http.post(url,
        body: json.encode({
          "Text": textAdd,
          "UserId": _valueDropdon,
          "PlaceDateTime": "2021-11-18T09:39:44"
        }),
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        }).then((http.Response response) {
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Nots is add"),
        ));
      }
    });
  }

  

  Future deletNote({
    required BuildContext context,
  }) async {
    var url = Uri.parse('$baseUrl/notes/clear');

    http.post(url, body: json.encode({}), headers: {
      'content-type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
    }).then((http.Response response) {
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Nots is Delete"),
        ));
        
      }
    });
    notifyListeners();
  }
}
