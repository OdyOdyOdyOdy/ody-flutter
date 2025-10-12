import "package:intl/intl.dart";
import "package:ody_flutter/data/entity/gathering/status_board_response.dart";
import "package:ody_flutter/domain/model/noti_log.dart";

extension ToDomain on StatusBoardResponse {
  List<NotiLog> toModel() => StatusBoardResponse(notifications: notifications)
      .notifications
      .map(
        (notification) => NotiLog(
          type: notification.type,
          nickname: notification.nickname,
          createdAt: DateFormat("yyyy-MM-dd HH:mm")
              .format(DateTime.parse(notification.createdAt)),
          imageUrl: notification.imageUrl,
        ),
      )
      .toList();
}
