import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";
import "package:location/location.dart";
import "package:ody_flutter/data/entity/gathering/enter_gathering_request.dart";
import "package:ody_flutter/di/di.dart";
import "package:ody_flutter/domain/model/location.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";
import "package:ody_flutter/domain/repository/location_repository.dart";
import "package:ody_flutter/screens/base/base_view_model.dart";
import "package:ody_flutter/screens/eta_board/eta_board_view_model.dart";
import "package:ody_flutter/utils/gathering_time_util.dart";

@injectable
class GatheringEnterViewModel extends BaseViewModel {
  GatheringEnterViewModel(
    this._locationRepository,
    this._gatheringRepository,
  );

  final LocationRepository _locationRepository;
  final GatheringRepository _gatheringRepository;
  LocationModel _currentLocation = LocationModel.init();
  String _invitationCode = "";
  final Location location = Location();
  int gatheringId = 0;
  String title = "";

  final ValueNotifier<bool> isCompleted = ValueNotifier(false);
  final ValueNotifier<String> locationText = ValueNotifier("");
  final ValueNotifier<bool> isConfirmEnabled = ValueNotifier(false);

  Future<void> setInvitationCode(String code) async => _invitationCode = code;

  void setLocation(LocationModel location) {
    _currentLocation = location;
    locationText.value = location.address ?? "알 수 없는 위치";
    isConfirmEnabled.value = true;
    notifyListeners();
  }

  Future<void> fetchCurrentLocation() async {
    await load(
      () async {
        await location.getLocation().then(
          (final LocationData locationData) async {
            _currentLocation = await _locationRepository.fetchLocationWithCoord(
              "${locationData.longitude}",
              "${locationData.latitude}",
            );
            locationText.value = "${_currentLocation.address}";
            isConfirmEnabled.value = true;
            notifyListeners();
          },
        );
      },
    );
  }

  Future<void> enterGathering() async {
    await load(
      () async {
        try {
          final EnterGatheringRequest request = EnterGatheringRequest(
            inviteCode: _invitationCode,
            originAddress: locationText.value,
            originLatitude: "${_currentLocation.latitude}",
            originLongitude: "${_currentLocation.longitude}",
          );

          final response = await _gatheringRepository.enterGathering(request);
          gatheringId = response.gatheringId;
          title = await _gatheringRepository
              .fetchGathering(response.gatheringId)
              .then(
                (final gathering) => gathering.name ?? "",
              );
          isCompleted.value = title.isNotEmpty;
          if (isWithin30Minutes(response.dateTime)) {
            await getIt<EtaBoardViewModel>()
                .startPolling(response.gatheringId, response.dateTime);
          }
        } on Exception catch (_) {
          isCompleted.value = false;
        }
      },
    );
  }
}
