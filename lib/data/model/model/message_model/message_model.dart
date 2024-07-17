class Message {
  List<String>? success;
  List<String>? error;

  Message({
    this.success,
    this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: json["success"] == null ? [] : List<String>.from(json["success"]!.map((x) => x)),
        error: json["error"] == null ? [] : List<String>.from(json["error"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? [] : List<dynamic>.from(success!.map((x) => x)),
        "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
      };
}
