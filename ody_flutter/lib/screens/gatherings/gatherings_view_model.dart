import "package:flutter/cupertino.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";

class GatheringsViewModel extends ChangeNotifier {
  GatheringsViewModel(this._gatheringRepository);

  final GatheringRepository _gatheringRepository;

  Future getGatherings() async {
    await _gatheringRepository.fetchGatherings();
  }
}
