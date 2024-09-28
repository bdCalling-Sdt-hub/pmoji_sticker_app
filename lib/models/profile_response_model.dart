
class ProfileResponseModel {
  final Information? information;

  ProfileResponseModel({
    this.information,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
    information: json["information"] == null ? null : Information.fromJson(json["information"]),
  );

  Map<String, dynamic> toJson() => {
    "information": information?.toJson(),
  };
}

class Information {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final ProfileImage? image;
  final String? role;
  final String? promoCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? address;
  final String? phone;

  Information({
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
    this.address,
    this.phone,
  });

  factory Information.fromJson(Map<String, dynamic> json) => Information(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    image: json["image"] == null ? null : ProfileImage.fromJson(json["image"]),
    role: json["role"],
    promoCode: json["promoCode"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    address: json["address"],
    phone: json["phone"],
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
    "address": address,
    "phone": phone,
  };
}

class ProfileImage {
  final String? publicFileUrl;
  final String? path;

  ProfileImage({
    this.publicFileUrl,
    this.path,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    publicFileUrl: json["publicFileURL"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrl,
    "path": path,
  };
}

