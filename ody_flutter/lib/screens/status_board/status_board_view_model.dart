import "package:injectable/injectable.dart";
import "package:ody_flutter/domain/model/gathering_detail.dart";
import "package:ody_flutter/domain/model/noti_log.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";
import "package:ody_flutter/screens/base/base_view_model.dart";

@injectable
class StatusBoardViewModel extends BaseViewModel {
  StatusBoardViewModel(this._gatheringRepository);

  final GatheringRepository _gatheringRepository;

  final List<NotiLog> _notiLogs = [];
  List<NotiLog> get notiLogs => _notiLogs;

  GatheringDetail? _detailGathering;
  GatheringDetail? get detailGathering => _detailGathering;

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
}
