
class AllStickerResponseModel {
  final String? id;
  final String? name;
  final AllStickerImage? image;
  final int? price;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  AllStickerResponseModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AllStickerResponseModel.fromJson(Map<String, dynamic> json) => AllStickerResponseModel(
    id: json["_id"],
    name: json["name"],
    image: json["image"] == null ? null : AllStickerImage.fromJson(json["image"]),
    price: json["price"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image?.toJson(),
    "price": price,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class AllStickerImage {
  final String? path;
  final String? publicFileUrl;

  AllStickerImage({
    this.path,
    this.publicFileUrl,
  });

  factory AllStickerImage.fromJson(Map<String, dynamic> json) => AllStickerImage(
    path: json["path"],
    publicFileUrl: json["publicFileURL"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "publicFileURL": publicFileUrl,
  };
}


