import "package:ody_flutter/domain/model/device_token.dart";

abstract class DeviceTokenRepository {
  Future<void> addToken();
  Future<DeviceToken?> getToken();
}
