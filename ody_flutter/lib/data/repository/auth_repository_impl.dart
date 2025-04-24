import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/entity/mapper/login_mapper.dart";
import "package:ody_flutter/data/network/service/auth_service.dart";
import "package:ody_flutter/domain/model/apple_login.dart";
import "package:ody_flutter/domain/model/auth_token.dart";
import "package:ody_flutter/domain/repository/auth_repository.dart";

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this.authService, this.authTokenService);

  final AuthService authService;
  final AuthTokenService authTokenService;

  @override
  Future<AuthToken> login(AppleLogin request) async {
    try {
      final response = await authService.appleLogin(request.toEntity());
      return response.toModel();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> withdrawal() async {
    try {
      final token = await authTokenService.getToken();
      final headers = {
        "Authorization": "Bearer access-token=${token?.accessToken}",
      };
      await authService.appleWithdrawal(headers);
      await authTokenService.deleteToken();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<int> saveToken(String accessToken, String refreshToken) async =>
      authTokenService.saveToken(
        AuthToken(
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
      );

  @override
  Future<AuthToken?> getToken() async {
    final AuthToken? authToken = await authTokenService.getToken();
    return authToken;
  }
}
