import "package:ody_flutter/assets/images/images.dart";

enum NotificationType {
  departureTime,
  entry;
}

enum NotificationSetting {
  departure(
    CommonImages.icNotification,
    "출발 시간 푸시 알림",
    NotificationType.departureTime,
  ),
  entry(
    CommonImages.icNotification,
    "약속 참여 푸시 알림",
    NotificationType.entry,
  );

  const NotificationSetting(this.icon, this.description, this.notificationType);

  final String icon;
  final String description;
  final NotificationType notificationType;
}
