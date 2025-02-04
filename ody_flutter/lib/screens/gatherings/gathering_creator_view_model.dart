import "package:flutter/cupertino.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";

class GatheringCreatorViewModel extends ChangeNotifier {
  GatheringCreatorViewModel(this._gathringRepository);

  final GatheringRepository _gathringRepository;
  Gathering? gathering;

  Future<void> createGathering(Gathering request) async {
    gathering = await _gathringRepository.createGathering(request);
    notifyListeners();
  }
}
