import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";
import "package:get_it/get_it.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/data/network/interceptor/refresh_token_interceptor.dart";
import "package:ody_flutter/di/di.config.dart";
import "package:ody_flutter/domain/repository/auth_repository.dart";

final getIt = GetIt.instance;
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

@InjectableInit(
  initializerName: "init",
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  getIt..init()
  ..registerSingleton<RouteObserver<ModalRoute<void>>>(routeObserver);
  _setupInterceptors();
}

void _setupInterceptors() {
  final dio = getIt<Dio>();
  final authRepository = getIt<AuthRepository>();
  dio.interceptors
      .add(RefreshTokenInterceptor(authRepository: authRepository, dio: dio));
}
