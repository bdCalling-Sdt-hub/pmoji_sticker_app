
import 'dart:convert';

UserInfoResponseModel userInfoResponseModelFromJson(String str) => UserInfoResponseModel.fromJson(json.decode(str));

String userInfoResponseModelToJson(UserInfoResponseModel data) => json.encode(data.toJson());

class UserInfoResponseModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final Image? image;
  final String? role;
  final String? promoCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserInfoResponseModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.image,
    this.role,
    this.promoCode,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserInfoResponseModel.fromJson(Map<String, dynamic> json) => UserInfoResponseModel(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    role: json["role"],
    promoCode: json["promoCode"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "image": image?.toJson(),
    "role": role,
    "promoCode": promoCode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Image {
  final String? publicFileUrl;
  final String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicFileUrl: json["publicFileURL"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrl,
    "path": path,
  };
}