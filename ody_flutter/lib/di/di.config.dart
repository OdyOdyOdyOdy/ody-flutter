// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/db/database_helper.dart' as _i756;
import '../data/db/service/auth_token_service.dart' as _i967;
import '../data/db/service/device_token_service.dart' as _i363;
import '../data/network/base/base_service.dart' as _i139;
import '../data/network/service/auth_service.dart' as _i308;
import '../data/network/service/gathering_service.dart' as _i1027;
import '../data/network/service/location_service.dart' as _i881;
import '../data/repository/auth_repository_impl.dart' as _i461;
import '../data/repository/device_token_repository_impl.dart' as _i320;
import '../data/repository/gathering_repository_impl.dart' as _i307;
import '../data/repository/location_repository_impl.dart' as _i601;
import '../domain/repository/auth_repository.dart' as _i306;
import '../domain/repository/device_token_repository.dart' as _i1010;
import '../domain/repository/gathering_repository.dart' as _i11;
import '../domain/repository/location_repository.dart' as _i201;
import '../screens/gathering_creator/gathering_creator_view_model.dart' as _i74;
import '../screens/gathering_creator/screens/gathering_location_view_model.dart'
    as _i485;
import '../screens/gathering_detail/gathering_detail_view_model.dart' as _i1000;
import '../screens/gathering_enter/gathering_enter_view_model.dart' as _i989;
import '../screens/gatherings/gatherings_view_model.dart' as _i384;
import '../screens/invitation_code/invitation_code_view_model.dart' as _i1054;
import '../screens/login/login_view_model.dart' as _i115;
import '../screens/settings/settings_view_model.dart' as _i1051;
import '../screens/splash/splash_view_model.dart' as _i737;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i363.DeviceTokenService>(() => _i363.DeviceTokenService());
    gh.factory<_i967.AuthTokenService>(() => _i967.AuthTokenService());
    gh.singleton<_i756.DatabaseHelper>(() => _i756.DatabaseHelper());
    gh.factory<_i139.BaseService>(
        () => _i139.BaseService(gh<_i967.AuthTokenService>()));
    gh.factory<_i1010.DeviceTokenRepository>(
        () => _i320.DeviceTokenRepositoryImpl(gh<_i363.DeviceTokenService>()));
    gh.factory<_i1027.GatheringService>(() => _i1027.GatheringService(
          gh<_i139.BaseService>(),
          gh<_i967.AuthTokenService>(),
        ));
    gh.factory<_i881.LocationService>(
        () => _i881.LocationService(gh<_i139.BaseService>()));
    gh.factory<_i308.AuthService>(
        () => _i308.AuthService(gh<_i139.BaseService>()));
    gh.factory<_i11.GatheringRepository>(() => _i307.GatheringRepositoryImpl(
          gh<_i1027.GatheringService>(),
          gh<_i967.AuthTokenService>(),
        ));
    gh.factory<_i201.LocationRepository>(
        () => _i601.LocationRepositoryImpl(gh<_i881.LocationService>()));
    gh.factory<_i989.GatheringEnterViewModel>(
        () => _i989.GatheringEnterViewModel(
              gh<_i201.LocationRepository>(),
              gh<_i11.GatheringRepository>(),
            ));
    gh.factory<_i485.GatheringLocationViewModel>(
        () => _i485.GatheringLocationViewModel(gh<_i201.LocationRepository>()));
    gh.factory<_i306.AuthRepository>(() => _i461.AuthRepositoryImpl(
          gh<_i308.AuthService>(),
          gh<_i967.AuthTokenService>(),
        ));
    gh.factory<_i1054.InvitationCodeViewModel>(
        () => _i1054.InvitationCodeViewModel(gh<_i11.GatheringRepository>()));
    gh.factory<_i74.GatheringCreatorViewModel>(
        () => _i74.GatheringCreatorViewModel(gh<_i11.GatheringRepository>()));
    gh.factory<_i1000.GatheringDetailViewModel>(
        () => _i1000.GatheringDetailViewModel(gh<_i11.GatheringRepository>()));
    gh.factory<_i384.GatheringsViewModel>(
        () => _i384.GatheringsViewModel(gh<_i11.GatheringRepository>()));
    gh.factory<_i115.LoginViewModel>(() => _i115.LoginViewModel(
          gh<_i306.AuthRepository>(),
          gh<_i1010.DeviceTokenRepository>(),
        ));
    gh.factory<_i1051.SettingViewModel>(
        () => _i1051.SettingViewModel(gh<_i306.AuthRepository>()));
    gh.factory<_i737.SplashViewModel>(
        () => _i737.SplashViewModel(gh<_i306.AuthRepository>()));
    return this;
  }
}
