import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:note_app_task/json/interest_json.dart';
import 'package:note_app_task/json/user_json.dart';
import 'package:note_app_task/utils/env.dart';

class UserModel with ChangeNotifier{


String? _valueDropdon;

  String? get getvalueDropdon => _valueDropdon;

  void setvalueDropdon(String value) {
    _valueDropdon = value;
    notifyListeners();
  }
String? _valueInterst;

  String? get getvalueInterst => _valueInterst;

  void setvalueInterst(String value) {
    _valueInterst = value;
    notifyListeners();
  }

  // ignore: prefer_final_fields
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setIsloading(bool val) {
    _isLoading = val;
  }
  Future addUser({
    required BuildContext context,
    String? password,
    String? email,
    String? userName,
    String? imageUrl,
  }) async {
    setIsloading = true;
    var url = Uri.parse('$baseUrl/users/insert');
    setIsloading = false;

    http.post(url,
        body: json.encode({
          "Username": userName,
          "Password": password,
          "Email": email,
          "ImageAsBase64": "null",
          "IntrestId": _valueInterst
        }),
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        }).then((http.Response response) {
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        setIsloading = false;

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User is updated"),
        ));
        setIsloading = false;
      }
    });
    notifyListeners();
  }


  


  Future<List<Interest>> loadInterest(BuildContext context) async {
    var url = Uri.parse('$baseUrl/intrests/getall');
    var response = await http.get(url, headers: {
      'content-type': 'multipart/form-data',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $token',
    });
    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      return interestFromJson(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }


}