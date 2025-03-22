import "package:firebase_messaging/firebase_messaging.dart";
import "package:ody_flutter/data/db/service/device_token_service.dart";
import "package:ody_flutter/domain/model/device_token.dart";
import "package:ody_flutter/domain/repository/device_token_repository.dart";

class DeviceTokenRepositoryImpl implements DeviceTokenRepository {
  DeviceTokenRepositoryImpl(this.deviceTokenService);

  final DeviceTokenService deviceTokenService;

  @override
  Future<DeviceToken?> getToken() async {
    final DeviceToken? deviceToken = await deviceTokenService.fetchToken();

    if (deviceToken == null) {
      await addToken();
      return deviceTokenService.fetchToken();
    }

    return deviceToken;
  }

  @override
  Future<int> addToken() async {
    final deviceToken = await FirebaseMessaging.instance.getToken();

    return deviceTokenService.addToken(DeviceToken(device: deviceToken));
  }
}
