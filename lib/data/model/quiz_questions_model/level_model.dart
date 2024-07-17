class Level {
  int? id;
  String? title;
  String? level;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Level({
    this.id,
    this.title,
    this.level,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    id: json["id"],
    title: json["title"],
    level: json["level"].toString(),
    status: json["status"].toString(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "level": level,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}