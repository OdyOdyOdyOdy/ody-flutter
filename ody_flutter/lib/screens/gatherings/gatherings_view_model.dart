import "package:flutter/cupertino.dart";
import "package:ody_flutter/domain/model/gathering2.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";

class GatheringsViewModel extends ChangeNotifier {
  GatheringsViewModel(this._gatheringRepository);

  final GatheringRepository _gatheringRepository;

  final List<Gathering2> _gatherings = [];
  List<Gathering2> get gatherings => _gatherings;

  Future getGatherings() async {
    final fetchedGatherings = await _gatheringRepository.fetchGatherings();
    _gatherings.addAll(fetchedGatherings);
    notifyListeners();
  }
}
