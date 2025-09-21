
import "package:dio/dio.dart";
import "package:get_it/get_it.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/data/network/interceptor/refresh_token_interceptor.dart";
import "package:ody_flutter/di/di.config.dart";
import "package:ody_flutter/domain/repository/auth_repository.dart";

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: "init",
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  getIt.init();
  _setupInterceptors();
}

void _setupInterceptors() {
  final dio = getIt<Dio>();
  final authRepository = getIt<AuthRepository>();
  dio.interceptors.add(RefreshTokenInterceptor(authRepository: authRepository, dio: dio));
}
