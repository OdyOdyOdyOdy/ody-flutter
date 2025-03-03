import "package:firebase_messaging/firebase_messaging.dart";
import "package:ody_flutter/data/db/service/token_service.dart";
import "package:ody_flutter/domain/model/token.dart";
import "package:ody_flutter/domain/repository/token_repository.dart";

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl(this.deviceTokenService);

  final DeviceTokenService deviceTokenService;

  @override
  Future<Token?> getToken() async {
    final Token? deviceToken = await deviceTokenService.fetchToken();

    if (deviceToken == null) {
      await addToken();
    }

    return deviceTokenService.fetchToken();
  }

  @override
  Future<int> addToken() async {
    final deviceToken = await FirebaseMessaging.instance.getToken();

    return deviceTokenService.insertToken(Token(device: deviceToken));
  }
}
