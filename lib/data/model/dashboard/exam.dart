class Exams {
  int? id;
  String? typeId;
  dynamic categoryId;
  dynamic subCategoryId;
  String? title;
  String? image;
  DateTime? startDate;
  DateTime? endDate;
  String? prize;
  String? point;
  dynamic description;
  dynamic levelId;
  String? examStartTime;
  String? examEndTime;
  String? examDuration;
  String? examKey;
  List<String>? examRule;
  String? status;
  String? winningMark;
  DateTime? createdAt;
  DateTime? updatedAt;

  Exams({
    this.id,
    this.typeId,
    this.categoryId,
    this.subCategoryId,
    this.title,
    this.image,
    this.startDate,
    this.endDate,
    this.prize,
    this.point,
    this.description,
    this.levelId,
    this.examStartTime,
    this.examEndTime,
    this.examDuration,
    this.examKey,
    this.examRule,
    this.status,
    this.winningMark,
    this.createdAt,
    this.updatedAt,
  });

  factory Exams.fromJson(Map<String, dynamic> json) => Exams(
    id: json["id"],
    typeId: json["type_id"].toString(),
    categoryId: json["category_id"].toString(),
    subCategoryId: json["sub_category_id"].toString(),
    title: json["title"],
    image: json["image"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    prize: json["prize"].toString(),
    point: json["point"].toString(),
    description: json["description"] ?? "",
    levelId: json["level_id"].toString(),
    examStartTime: json["exam_start_time"].toString(),
    examEndTime: json["exam_end_time"],
    examDuration: json["exam_duration"].toString(),
    examKey: json["exam_key"],
    examRule: json["exam_rule"] == null || json["exam_rule"].toString() == '0' ? [] : List<String>.from(json["exam_rule"]!.map((x) => x)),
    status: json["status"].toString(),
    winningMark: json["winning_mark"].toString(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type_id": typeId,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "title": title,
    "image": image,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "prize": prize,
    "point": point,
    "description": description,
    "level_id": levelId,
    "exam_start_time": examStartTime,
    "exam_end_time": examEndTime,
    "exam_duration": examDuration,
    "exam_key": examKey,
    "exam_rule": examRule,
    "status": status,
    "winning_mark": winningMark,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}