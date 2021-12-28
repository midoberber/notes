// To parse this JSON data, do
//
//     final interest = interestFromJson(jsonString);

import 'dart:convert';

List<Interest> interestFromJson(String str) => List<Interest>.from(json.decode(str).map((x) => Interest.fromJson(x)));


class Interest {
    Interest({
        this.intrestText,
        this.id,
    });

    String ?intrestText;
    String ?id;

    factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        intrestText: json["intrestText"],
        id: json["id"],
    );
}
    
