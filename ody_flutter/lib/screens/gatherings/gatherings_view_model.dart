import "package:injectable/injectable.dart";
import "package:ody_flutter/domain/model/gathering2.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";
import "package:ody_flutter/presentation/base/base_view_model.dart";

@injectable
class GatheringsViewModel extends BaseViewModel {
  GatheringsViewModel(this._gatheringRepository);

  final GatheringRepository _gatheringRepository;

  final List<Gathering2> _gatherings = [];

  List<Gathering2> get gatherings => _gatherings;

  Future getGatherings() async {
    await load(
      () async {
        final fetchedGatherings = await _gatheringRepository.fetchGatherings();
        _gatherings.addAll(fetchedGatherings);
      },
    );
  }
}
