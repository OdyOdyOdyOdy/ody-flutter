import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";

@injectable
class InvitationCodeViewModel extends ChangeNotifier {
  InvitationCodeViewModel(this._gatheringRepository) {
    _init();
  }

  final GatheringRepository _gatheringRepository;

  final ValueNotifier<String> text = ValueNotifier("");
  final ValueNotifier<bool> isConfirmEnabled = ValueNotifier(false);
  final ValueNotifier<bool> isValidCode = ValueNotifier(false);

  String get currentInvitationCode => text.value;

  void _init() => text.addListener(() {
        isConfirmEnabled.value = text.value.isNotEmpty;
      });

  Future<void> enterInvitationCode() async {
    try {
      final isValid = await _gatheringRepository
          .validateInvitationCode(currentInvitationCode);
      isValidCode.value = isValid;
    } on Exception catch (_) {
      isValidCode.value = false;
    }
  }
}
