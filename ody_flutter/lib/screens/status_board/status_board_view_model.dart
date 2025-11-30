import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/domain/model/gathering_detail.dart";
import "package:ody_flutter/domain/model/noti_log.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";
import "package:ody_flutter/screens/base/base_view_model.dart";
import "package:ody_flutter/screens/status_board/status_board_navigate_action.dart";

@injectable
class StatusBoardViewModel extends BaseViewModel {
  StatusBoardViewModel(this._gatheringRepository);

  final GatheringRepository _gatheringRepository;

  final List<NotiLog> _notiLogs = [];
  List<NotiLog> get notiLogs => _notiLogs;

  GatheringDetail? _detailGathering;
  GatheringDetail? get detailGathering => _detailGathering;

  ValueNotifier<StatusBoardNavigateAction?> navigation =
      ValueNotifier(null);

  Future getStatusBoard(int meetingId) async {
    await load(
      () async {
        final fetchedStatusBoard =
            await _gatheringRepository.fetchStatusBoard(meetingId);
        _notiLogs.addAll(fetchedStatusBoard);
      },
    );
  }

  Future getDetailGathering(int id) async {
    _detailGathering = await _gatheringRepository.fetchGathering(id);
    notifyListeners();
  }

  Future exitMeeting(int meetingId) async {
    await load(() async {
      await _gatheringRepository.exitMeeting(meetingId);
      navigation.value = NavigateToGatherings();
      notifyListeners();
    });
  }
}
