import "package:ody_flutter/domain/model/apple_login.dart";
import "package:ody_flutter/domain/model/auth_token.dart";

abstract class AuthRepository {
  Future<AuthToken> login(AppleLogin request);

  Future<void> withdrawal();

  Future<void> saveToken(String accessToken, String refreshToken);

  Future<AuthToken?> getToken();
}
