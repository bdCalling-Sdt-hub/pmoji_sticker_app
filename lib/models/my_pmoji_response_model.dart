
import 'package:flutter/material.dart';

class MyPmojiResponseModel {
  var sId;
  var name;
  final ImagePmoji? image;
  var price;
  var description;
  var createdAt;
  var updatedAt;
  var iV;

  MyPmojiResponseModel({
    this.sId,
    this.name,
    this.image,
    this.price,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.iV});

  factory MyPmojiResponseModel.fromJson(Map<String, dynamic> json) =>
      MyPmojiResponseModel(
        sId: json["_id"],
        name: json["name"],
        image: json["image"] == null ? null : ImagePmoji.fromJson(json["image"]),
        price: json["price"],
        description: json["description"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        iV: json["iV"],


      );

  Map<String, dynamic> toJson() =>
      {
        "_id": sId,
        "name": name,
        "image": image?.toJson(),
        "price": price,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "iV": iV,

      };
}
class ImagePmoji {
  var path;
  var publicFileURL;

  ImagePmoji({this.path, this.publicFileURL});

  factory ImagePmoji.fromJson(Map<String, dynamic> json) => ImagePmoji(
    publicFileURL: json["publicFileURL"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileURL,
    "path": path,
  };
}
