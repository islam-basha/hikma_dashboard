// To parse this JSON data, do
//
//     final booksModel = booksModelFromJson(jsonString);

import 'dart:convert';

List<BooksModel> booksModelFromJson(String str) => List<BooksModel>.from(json.decode(str).map((x) => BooksModel.fromJson(x)));

String booksModelToJson(List<BooksModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BooksModel {
  String name;
  String author;
  String publish;
  int id;

  BooksModel({
    required this.name,
    required this.author,
    required this.publish,
    required this.id,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) => BooksModel(
    name: json["name"],
    author: json["author"],
    publish: json["publish"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "author": author,
    "publish": publish,
    "id": id,
  };
}
