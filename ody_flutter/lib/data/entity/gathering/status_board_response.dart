class StatusBoardResponse {
  StatusBoardResponse({required this.notifications});

  factory StatusBoardResponse.fromJson(Map<String, dynamic> json) =>
      StatusBoardResponse(
        notifications: (json["notiLog"] as List)
            .map((item) => NotificationResponse.fromJson(item))
            .toList(),
      );
  final List<NotificationResponse> notifications;

  Map<String, dynamic> toJson() => {
        "notiLog": notifications.map((meeting) => meeting.toJson()).toList(),
      };
}

class NotificationResponse {
  NotificationResponse({
    required this.type,
    required this.nickname,
    required this.createdAt,
    required this.imageUrl,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        type: json["type"],
        nickname: json["nickname"],
        createdAt: json["createdAt"],
        imageUrl: json["imageUrl"],
      );
  final String type;
  final String nickname;
  final String createdAt;
  final String imageUrl;

  Map<String, dynamic> toJson() => {
        "type": type,
        "nickname": nickname,
        "createdAt": createdAt,
        "imageUrl": imageUrl,
      };
}
