// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));


class User {
    User({
        this.username,
        this.password,
        this.email,
        this.imageAsBase64,
        this.intrestId,
        this.id,
    });

    String? username;
    String ?password;
    String? email;
    String? imageAsBase64;
    String? intrestId;
    String? id;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        imageAsBase64: json["imageAsBase64"] ,
        intrestId: json["intrestId"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "imageAsBase64": imageAsBase64 ,
        "intrestId": intrestId,
        "id": id,
    };
}
