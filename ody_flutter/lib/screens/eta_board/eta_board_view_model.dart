import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/domain/model/nudge.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";
import "package:ody_flutter/screens/gathering_detail/gathering_detail_navigate_action.dart";

@injectable
class EtaBoardViewModel extends ChangeNotifier {
  EtaBoardViewModel(this._gatheringRepository);

  final GatheringRepository _gatheringRepository;

  ValueNotifier<GatheringDetailNavigateAction?> navigation =
      ValueNotifier(null);

  Future exitMeeting(int meetingId) async {
    await _gatheringRepository.exitMeeting(meetingId);
    navigation.value = NavigateToGatherings();
    notifyListeners();
  }

  Future performNudge(
    int userId,
    int mateId,
    String mateNickname,
  ) async {
    await _gatheringRepository.postNudge(
      Nudge(
        requestMateId: userId,
        nudgedMateId: mateId,
      ),
    );
  }
}
