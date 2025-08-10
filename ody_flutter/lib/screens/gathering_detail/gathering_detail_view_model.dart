import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/domain/model/gathering_detail.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";
import "package:ody_flutter/screens/gathering_detail/gathering_detail_navigate_action.dart";

@injectable
class GatheringDetailViewModel extends ChangeNotifier {
  GatheringDetailViewModel(this._gatheringRepository);

  final GatheringRepository _gatheringRepository;

  GatheringDetail? _detailGathering;

  GatheringDetail? get detailGathering => _detailGathering;
  ValueNotifier<GatheringDetailNavigateAction?> navigation =
      ValueNotifier(null);

  Future getDetailGathering(int id) async {
    _detailGathering = await _gatheringRepository.fetchGathering(id);
    notifyListeners();
  }

  Future exitMeeting(int meetingId) async {
    await _gatheringRepository.exitMeeting(meetingId);
    navigation.value = NavigateToGatherings();
    notifyListeners();
  }
}
