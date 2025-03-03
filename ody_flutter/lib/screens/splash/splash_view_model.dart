import "package:ody_flutter/domain/model/token.dart";
import "package:ody_flutter/domain/repository/token_repository.dart";
import "package:ody_flutter/screens/splash/splash_navigate_action.dart";

class SplashViewModel {
  SplashViewModel(this._tokenRepository);

  final TokenRepository _tokenRepository;
  SplashNavigateAction? navigation;

  Future<void> hasToken() async {
    final Token? deviceToken = await _tokenRepository.getToken();
    // 추후에 엑세스 토큰 리플레쉬 토큰으로 분기 필요
    navigation = NavigateToLogin();
  }
}
