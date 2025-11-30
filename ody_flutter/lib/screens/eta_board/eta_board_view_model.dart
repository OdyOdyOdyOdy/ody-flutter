import "dart:async";
import "dart:typed_data";

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
import "package:screenshot/screenshot.dart";
import "package:share_plus/share_plus.dart";

@injectable
class EtaBoardViewModel extends BaseViewModel {
  EtaBoardViewModel(this._gatheringRepository, this._etaRepository);

  final GatheringRepository _gatheringRepository;
  final EtaRepository _etaRepository;

  UserEta? userEta;
  ValueNotifier<GatheringDetailNavigateAction?> navigation =
      ValueNotifier(null);
  Timer? _timer;

  Future<void> startPolling(int gatheringId, String time) async {
    final now = DateTime.now();
    final meetingTime = DateTime.parse(time);

    if (now.isAfter(meetingTime)) {
      return;
    }
    await patchEtaBoard(gatheringId);

    _timer = Timer.periodic(const Duration(seconds: 10), (_) async {
      DateTime.now().isAfter(meetingTime)
          ? stopPolling()
          : await patchEtaBoard(gatheringId);
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

  Future<void> performNudge({
    required int nudgedMateId,
    required String nudgedMateName,
  }) async {
    if (userEta == null) {
      return;
    }
    final requesterId = userEta!.requesterMateId;

    if (requesterId == nudgedMateId) {
      return;
    }

    final response = await _gatheringRepository.postNudge(
      Nudge(
        requestMateId: requesterId,
        nudgedMateId: nudgedMateId,
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        await Fluttertoast.showToast(msg: "$nudgedMateName에게 빨리 오라고 재촉했어요!");
      case 400:
        await Fluttertoast.showToast(msg: "약속 시간 30분 이후에는 재촉할 수 없어요");
      default:
        await Fluttertoast.showToast(msg: "에러가 발생했습니다");
    }
  }

  Future<void> patchEtaBoard(int gatheringId) async {
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
  }

  Future<void> shareScreenshot(
    ScreenshotController screenshotController,
  ) async {
    try {
      Uint8List? image;
      await load(
        () async {
          image = await screenshotController.capture();
        },
      );
      if (image != null) {
        final params = ShareParams(
          files: [
            XFile.fromData(
              image!,
              name: "ody_eta_board.png",
              mimeType: "image/png",
            ),
          ],
        );
        final result = await SharePlus.instance.share(params);
        if (result.status == ShareResultStatus.success) {
          debugPrint("스크린샷 공유 성공");
        } else {
          debugPrint("스크린샷 공유 실패");
        }
      }
    } on Exception catch (e) {
      debugPrint("스크린샷 공유 중 예외 발생: $e");
    }
  }
}
