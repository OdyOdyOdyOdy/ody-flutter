import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/cupertino.dart";
import "package:ody_flutter/domain/model/apple_login.dart";
import "package:ody_flutter/domain/model/auth_token.dart";
import "package:ody_flutter/domain/model/device_token.dart";
import "package:ody_flutter/domain/repository/auth_repository.dart";
import "package:ody_flutter/domain/repository/device_token_repository.dart";
import "package:ody_flutter/screens/login/login_navigate_action.dart";

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._authRepository, this._tokenRepository);

  final AuthRepository _authRepository;
  final DeviceTokenRepository _tokenRepository;
  ValueNotifier<LoginNavigateAction?> navigation = ValueNotifier(null);

  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
    notifyListeners();
  }

  Future login(
    String? providerId,
    String? nickname,
    String? authorizationCode,
  ) async {
    final DeviceToken? deviceToken = await _tokenRepository.getToken();
    final AppleLogin request = AppleLogin(
      deviceToken: deviceToken?.device,
      providerId: providerId,
      nickname: nickname,
      imageUrl: "",
      authorizationCode: authorizationCode,
    );
    final AuthToken authToken = await _authRepository.login(request);
    await _authRepository.saveToken(
      authToken.accessToken!,
      authToken.refreshToken!,
    );

    navigation.value = NavigateToGatherings();
  }
}
