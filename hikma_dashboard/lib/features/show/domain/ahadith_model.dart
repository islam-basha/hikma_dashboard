// To parse this JSON data, do
//
//     final ahadithModel = ahadithModelFromJson(jsonString);

import 'dart:convert';

List<AhadithModel> ahadithModelFromJson(String str) => List<AhadithModel>.from(json.decode(str).map((x) => AhadithModel.fromJson(x)));

String ahadithModelToJson(List<AhadithModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AhadithModel {
  int id;
  String hadith;
  String hokm;
  int bookId;

  AhadithModel({
    required this.id,
    required this.hadith,
    required this.hokm,
    required this.bookId,
  });

  factory AhadithModel.fromJson(Map<String, dynamic> json) => AhadithModel(
    id: json["id"],
    hadith: json["hadith"],
    hokm: json["hokm"],
    bookId: json["book_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hadith": hadith,
    "hokm": hokm,
    "book_id": bookId,
  };
}
