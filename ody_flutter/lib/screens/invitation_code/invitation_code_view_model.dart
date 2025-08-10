import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";

@injectable
class InvitationCodeViewModel extends ChangeNotifier {
  InvitationCodeViewModel() {
    _init();
  }

  final ValueNotifier<String> text = ValueNotifier("");
  final ValueNotifier<bool> isConfirmEnabled = ValueNotifier(false);
  final ValueNotifier<bool> isValidCode = ValueNotifier(false);

  void _init() => text.addListener(() {
        isConfirmEnabled.value = text.value.isNotEmpty;
      });

  Future<void> enterInvitationCode() async {
    // to do: 초대 코드 입력 API 호출
    isValidCode.value = true;
  }
}
