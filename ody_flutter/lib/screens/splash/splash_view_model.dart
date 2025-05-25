import "package:ody_flutter/domain/model/auth_token.dart";
import "package:ody_flutter/domain/repository/auth_repository.dart";
import "package:ody_flutter/screens/splash/splash_navigate_action.dart";

class SplashViewModel {
  SplashViewModel(this._authRepository);

  final AuthRepository _authRepository;

  SplashNavigateAction? navigation;

  Future<void> hasToken() async {
    final AuthToken? authToken = await _authRepository.getToken();

    if (authToken == null) {
      navigation = NavigateToLogin();
    } else {
      navigation = NavigateToGatherings();
    }
  }
}
