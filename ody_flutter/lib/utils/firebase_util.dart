import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:ody_flutter/di/di.dart";
import "package:ody_flutter/screens/eta_board/eta_board_view_model.dart";
import "package:ody_flutter/utils/fcm_type.dart";

final viewModel = getIt<EtaBoardViewModel>();

Future<void> onMessageReceived(RemoteMessage message) async {
  final String type = message.data["type"] ?? "";
  final FCMType fcmType = FCMType.from(type);
  final String nickname = message.data["nickname"] ?? "";
  final int gatheringId =
      int.tryParse(message.data["meetingId"]?.toString() ?? "") ?? 0;
  final String title = message.data["meetingName"] ?? "";
  final String time = message.data["meetingTime"] ?? "";

  debugPrint(
    """
    [FCM] onMessageReceived
    type: $type
    fcmType: $fcmType
    nickname: $nickname
    gatheringId: $gatheringId
    title: $title
    time: $time
    """,
  );

  if (fcmType == MessageType.etaSchedulingNotice) {
    await viewModel.startPolling(gatheringId, time);
  }
}
