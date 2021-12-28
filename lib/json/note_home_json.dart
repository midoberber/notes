// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

import 'dart:convert';

List<Notes> notesFromJson(String str) =>
    List<Notes>.from(json.decode(str).map((x) => Notes.fromJson(x)));

class Notes {
  Notes({
    this.text,
    this.placeDateTime,
    this.userId,
    this.id,
  });

  String? text;
  DateTime? placeDateTime;
  String? userId;
  String? id;

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        text: json["text"],
        placeDateTime: DateTime.parse(json["placeDateTime"]),
        userId: json["userId"],
        id: json["id"],
      );
}
