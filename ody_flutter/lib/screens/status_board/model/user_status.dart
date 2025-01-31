import "package:ody_flutter/screens/status_board/model/user_notification_type.dart";

class UserStatus {
  UserStatus({
    required this.nickname,
    required this.created,
    required this.imageUrl,
    required this.userNotificationType,
  });

  final String nickname;
  final String created;
  final String imageUrl;
  final UserNotificationType userNotificationType;
}
