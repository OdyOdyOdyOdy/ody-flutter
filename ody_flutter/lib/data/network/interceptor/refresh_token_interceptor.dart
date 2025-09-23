import "package:dio/dio.dart";
import "package:ody_flutter/domain/repository/auth_repository.dart";
import "package:synchronized/synchronized.dart";

class RefreshTokenInterceptor extends QueuedInterceptorsWrapper {
  RefreshTokenInterceptor({
    required this.authRepository,
    required this.dio,
  });

  final AuthRepository authRepository;
  final Dio dio;
  final _lock = Lock();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _lock.synchronized(() async {
        try {
          final newAuthToken = await authRepository.postRefreshToken();

          final requestOptions = err.requestOptions;
          requestOptions.headers["Authorization"] =
              "Bearer access-token=${newAuthToken.accessToken}";

          final response = await dio.fetch(requestOptions);
          return handler.resolve(response);
        } on DioException catch (e) {
          return handler.reject(e);
        }
      });
    } else {
      return handler.next(err);
    }
  }
}
