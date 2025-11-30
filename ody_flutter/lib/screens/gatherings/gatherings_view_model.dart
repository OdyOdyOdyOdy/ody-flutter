import "package:flutter/material.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";

@injectable
class GatheringsViewModel extends ChangeNotifier {
  GatheringsViewModel(this._gatheringRepository);

  final GatheringRepository _gatheringRepository;

  final List<Gathering> _gatherings = [];

  List<Gathering> get gatherings => _gatherings;

  Future getGatherings() async {
    final fetchedGatherings = await _gatheringRepository.fetchGatherings();
    _gatherings
      ..clear()
      ..addAll(fetchedGatherings);
    notifyListeners();
  }
}
