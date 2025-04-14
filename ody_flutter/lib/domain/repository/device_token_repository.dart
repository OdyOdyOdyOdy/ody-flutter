import "package:ody_flutter/domain/model/device_token.dart";

abstract class DeviceTokenRepository {
  Future<void> saveToken();
  Future<DeviceToken?> getToken();
}
