import "dart:async";

import "package:flutter/cupertino.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/data/entity/eta/user_eta_request.dart";
import "package:ody_flutter/domain/model/nudge.dart";
import "package:ody_flutter/domain/model/user_eta.dart";
import "package:ody_flutter/domain/repository/eta_repository.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";
import "package:ody_flutter/screens/base/base_view_model.dart";
import "package:ody_flutter/screens/gathering_detail/gathering_detail_navigate_action.dart";
import "package:ody_flutter/utils/location_util.dart";

@injectable
class EtaBoardViewModel extends BaseViewModel {
  EtaBoardViewModel(this._gatheringRepository, this._etaRepository);

  final GatheringRepository _gatheringRepository;
  final EtaRepository _etaRepository;

  UserEta? userEta;
  ValueNotifier<GatheringDetailNavigateAction?> navigation =
      ValueNotifier(null);
  Timer? _timer;

  Future<void> startPolling(int gatheringId) async {
    await patchEtaBoard(gatheringId);
    _timer = Timer.periodic(const Duration(seconds: 10), (_) async {
      await patchEtaBoard(gatheringId);
    });
  }

  void stopPolling() {
    _timer?.cancel();
  }

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

  Future<void> patchEtaBoard(
    int gatheringId,
  ) async {
    await load(
      () async {
        EtaRequest request;
        try {
          final position = await getCurrentLocation();
          if (position != null) {
            request = EtaRequest(
              isMissing: false,
              currentLatitude: position.latitude ?? 0.0,
              currentLongitude: position.longitude ?? 0.0,
            );
          } else {
            // 위치 정보는 가져왔지만 null인 경우
            request = const EtaRequest(
              isMissing: true,
              currentLatitude: 0,
              currentLongitude: 0,
            );
            await Fluttertoast.showToast(msg: "위치 정보를 가져오지 못했습니다");
          }
        } on Exception catch (_) {
          // 위치 정보 조회 중 예외 발생
          request = const EtaRequest(
            isMissing: true,
            currentLatitude: 0,
            currentLongitude: 0,
          );
          await Fluttertoast.showToast(msg: "위치 정보를 가져오는 데 실패했습니다");
        }

        try {
          userEta = await _etaRepository.patchEtaBoard(
            meetingId: gatheringId,
            request: request,
          );
          notifyListeners();
        } on Exception catch (e) {
          await Fluttertoast.showToast(msg: "도착 정보를 업데이트하지 못했습니다 ($e)");
        }
      },
    );
  }
}
