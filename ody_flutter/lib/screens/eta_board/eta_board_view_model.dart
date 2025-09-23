import "package:flutter/cupertino.dart";
import "package:fluttertoast/fluttertoast.dart";
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
  ) async {
    const String targetMate = "hello";

    final response = await _gatheringRepository.postNudge(
      Nudge(
        requestMateId: userId,
        nudgedMateId: mateId,
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        await Fluttertoast.showToast(msg: "$targetMate에게 빨리 오라고 재촉했어요!");
      case 400:
        await Fluttertoast.showToast(msg: "약속 시간 30분 이후에는 재촉할 수 없어요");
      default:
        await Fluttertoast.showToast(msg: "에러가 발생했습니다");
    }
  }
}
