import "package:flutter/cupertino.dart";
import "package:ody_flutter/domain/repository/auth_repository.dart";
import "package:ody_flutter/screens/settings/settings_navigate_action.dart";

class SettingViewModel extends ChangeNotifier {
  SettingViewModel(this._authRepository);

  final AuthRepository _authRepository;
  ValueNotifier<SettingsNavigateAction?> navigation = ValueNotifier(null);

  Future appleWithdrawal() async {
    await _authRepository.withdrawal();
    navigation.value = NavigateToLogin();
  }

  Future appleLogout() async {
    await _authRepository.logout();
    navigation.value = NavigateToLogin();
  }
}
