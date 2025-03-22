import "package:ody_flutter/data/entity/auth/apple_login_request.dart";
import "package:ody_flutter/data/entity/auth/login_response.dart";
import "package:ody_flutter/domain/model/apple_login.dart";
import "package:ody_flutter/domain/model/auth_token.dart";

extension ToData on AppleLogin {
  AppleLoginRequest toEntity() => AppleLoginRequest(
        deviceToken: deviceToken,
        providerId: providerId,
        nickname: nickname,
        imageUrl: imageUrl,
        authorizationCode: authorizationCode,
      );
}

extension ToDomain on LoginResponse {
  AuthToken toModel() => AuthToken(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}
