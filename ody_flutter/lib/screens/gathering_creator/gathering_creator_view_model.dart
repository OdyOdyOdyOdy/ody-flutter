import "package:flutter/cupertino.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";

class GatheringCreatorViewModel extends ChangeNotifier {
  GatheringCreatorViewModel(this._gathringRepository) {
    _init();
  }

  final GatheringRepository _gathringRepository;
  Gathering? gathering;
  final ValueNotifier<String> text = ValueNotifier("");
  final ValueNotifier<String> locationText = ValueNotifier("");
  final ValueNotifier<bool> isConfirmEnabled = ValueNotifier(false);

  void _init() => text.addListener(() {
        isConfirmEnabled.value = text.value.isNotEmpty;
      });

  Future<void> createGathering(Gathering request) async {
    gathering = await _gathringRepository.createGathering(request);
    notifyListeners();
  }
}
