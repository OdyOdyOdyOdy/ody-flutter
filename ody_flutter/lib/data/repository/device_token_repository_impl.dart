import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/foundation.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/data/db/service/device_token_service.dart";
import "package:ody_flutter/domain/model/device_token.dart";
import "package:ody_flutter/domain/repository/device_token_repository.dart";

@Injectable(as: DeviceTokenRepository)
class DeviceTokenRepositoryImpl implements DeviceTokenRepository {
  DeviceTokenRepositoryImpl(this.deviceTokenService);

  final DeviceTokenService deviceTokenService;

  @override
  Future<DeviceToken?> getToken() async {
    final DeviceToken? deviceToken = await deviceTokenService.getToken();
    debugPrint("Retrieved FCM Token from DB: ${deviceToken?.device}");

    if (deviceToken == null) {
      await saveToken();
      return deviceTokenService.getToken();
    }

    return deviceToken;
  }

  @override
  Future<int> saveToken() async {
    try {
      final deviceToken = await FirebaseMessaging.instance.getToken();
      return deviceTokenService.saveToken(DeviceToken(device: deviceToken));
    } on Exception catch (e) {
      debugPrint("Error fetching FCM token: $e");
      return 0; // or handle the error as needed
    }
  }
}
