import "package:dio/dio.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/entity/auth/login_response.dart";
import "package:ody_flutter/data/entity/mapper/login_mapper.dart";
import "package:ody_flutter/data/network/service/auth_service.dart";
import "package:ody_flutter/domain/model/apple_login.dart";
import "package:ody_flutter/domain/model/auth_token.dart";
import "package:ody_flutter/domain/repository/auth_repository.dart";

@Injectable(as: AuthRepository)
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
      await authService.appleWithdrawal();
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

  @override
  Future<void> logout() async {
    await authTokenService.deleteToken();
  }

  @override
  Future<AuthToken> postRefreshToken() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.get("BASE_DEV_URL"),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: Headers.jsonContentType,
      ),
    );

    try {
      final token = await getToken();
      if (token?.refreshToken == null) {
        throw Exception("No refresh token available");
      }

      final response = await dio.post(
        "/v1/auth/refresh",
        data: {"refreshToken": token!.refreshToken},
      );

      final newAuthToken = LoginResponse.fromJson(response.data).toModel();
      await saveToken(
        newAuthToken.accessToken.toString(),
        newAuthToken.refreshToken.toString(),
      );
      return newAuthToken;
    } catch (e) {
      await logout();
      rethrow;
    }
  }
}
