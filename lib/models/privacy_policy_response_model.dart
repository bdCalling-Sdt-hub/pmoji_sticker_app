
class PrivacyResponseModel {
  final String? id;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PrivacyResponseModel({
    this.id,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PrivacyResponseModel.fromJson(Map<String, dynamic> json) => PrivacyResponseModel(
    id: json["_id"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
