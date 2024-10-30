// To parse this JSON data, do
//
//     final hadithModel = hadithModelFromJson(jsonString);

import 'dart:convert';

HadithModel hadithModelFromJson(String str) => HadithModel.fromJson(json.decode(str));

String hadithModelToJson(HadithModel data) => json.encode(data.toJson());

class HadithModel {
  int id;
  String hadith;
  String hokm;
  int bookId;

  HadithModel({
    required this.id,
    required this.hadith,
    required this.hokm,
    required this.bookId,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) => HadithModel(
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
