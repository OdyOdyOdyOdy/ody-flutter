import "package:ody_flutter/data/entity/auth/apple_login_request.dart";
import "package:ody_flutter/data/entity/auth/login_response.dart";
import "package:ody_flutter/data/network/base/base_service.dart";

class AuthService {
  AuthService(this.baseService);

  final BaseService baseService;

  Future<LoginResponse> appleLogin(AppleLoginRequest request) async {
    try {
      final response = await baseService.postWithResponse(
        path: "/v1/auth/apple",
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> appleWithdrawal() async {
    try {
      await baseService.deleteWithResponse(
        path: "/v2/members",
      );
    } catch (_) {
      rethrow;
    }
  }
}
