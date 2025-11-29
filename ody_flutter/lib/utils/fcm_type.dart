mixin FCMType {
  static FCMType from(String type) {
    switch (type) {
      case "ENTRY":
        return NotificationType.entry;
      case "DEPARTURE_REMINDER":
        return NotificationType.departureReminder;
      case "NUDGE":
        return NotificationType.nudge;
      case "ETA_NOTICE":
        return NotificationType.etaNotice;
      case "ETA_SCHEDULING_NOTICE":
        return MessageType.etaSchedulingNotice;
      default:
        throw ArgumentError("존재하지 않는 FCMType입니다. - $type");
    }
  }
}

enum NotificationType implements FCMType {
  entry,
  departureReminder,
  nudge,
  etaNotice,
}

enum MessageType implements FCMType {
  etaSchedulingNotice,
}
