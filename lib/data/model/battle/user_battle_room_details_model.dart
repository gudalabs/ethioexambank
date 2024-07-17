class UserBattleRoomDetailsModel {
  final String name;
  final String profileUrl;
  final String uid;
  final int correctAnswers;
  final List answers;
  final int points;
  final bool status;

  UserBattleRoomDetailsModel(
      {required this.points,
      required this.answers,
      required this.correctAnswers,
      required this.name,
      required this.profileUrl,
      required this.uid,
      required this.status});

  static UserBattleRoomDetailsModel fromJson(Map json) {
    return UserBattleRoomDetailsModel(
      answers: json['answers'] as List? ?? [],
      points: json['points'] ?? 0,
      correctAnswers: json['correctAnswers'] ?? 0,
      name: json['name'] ?? "",
      profileUrl: json['profileUrl'] ?? "",
      uid: json['uid'] ?? "",
      status: json['status'] ?? false,
    );
  }
}
