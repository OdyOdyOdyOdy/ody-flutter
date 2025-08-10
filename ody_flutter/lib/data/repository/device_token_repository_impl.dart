import "package:firebase_messaging/firebase_messaging.dart";
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

    if (deviceToken == null) {
      await saveToken();
      return deviceTokenService.getToken();
    }

    return deviceToken;
  }

  @override
  Future<int> saveToken() async {
    final deviceToken = await FirebaseMessaging.instance.getToken();

    return deviceTokenService.saveToken(DeviceToken(device: deviceToken));
  }
}
