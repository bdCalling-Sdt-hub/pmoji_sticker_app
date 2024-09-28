
class AllNotificationResponseModel {
  final String? id;
  final String? msg;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AllNotificationResponseModel({
    this.id,
    this.msg,
    this.createdAt,
    this.updatedAt,
  });

  factory AllNotificationResponseModel.fromJson(Map<String, dynamic> json) => AllNotificationResponseModel(
    id: json["_id"],
    msg: json["msg"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "msg": msg,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
