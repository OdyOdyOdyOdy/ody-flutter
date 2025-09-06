import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";
import "package:location/location.dart";
import "package:ody_flutter/data/entity/gathering/enter_gathering_request.dart";
import "package:ody_flutter/domain/model/location.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";
import "package:ody_flutter/domain/repository/location_repository.dart";

@injectable
class GatheringEnterViewModel extends ChangeNotifier {
  GatheringEnterViewModel(
    this._locationRepository,
    this._gatheringRepository,
  );

  final LocationRepository _locationRepository;
  final GatheringRepository _gatheringRepository;
  LocationModel _currentLocation = LocationModel.init();
  String _invitationCode = "";

  final ValueNotifier<String> locationText = ValueNotifier("");
  final ValueNotifier<bool> isConfirmEnabled = ValueNotifier(false);
  final ValueNotifier<bool> isCompleted = ValueNotifier(false);

  Future<void> setInvitationCode(String code) async => _invitationCode = code;

  void setLocation(LocationModel location) {
    _currentLocation = location;
    locationText.value = location.name ?? location.address ?? "알 수 없는 위치";
    isConfirmEnabled.value = true;
    notifyListeners();
  }

  Future<void> fetchCurrentLocation() async {
    final Location location = Location();

    await location.getLocation().then((final LocationData locationData) async {
      _currentLocation = await _locationRepository.fetchLocationWithCoord(
        "${locationData.longitude}",
        "${locationData.latitude}",
      );
      locationText.value = "${_currentLocation.name}";
      isConfirmEnabled.value = true;
      notifyListeners();
    });
  }

  Future<void> enterGathering() async {
    try {
      final EnterGatheringRequest request = EnterGatheringRequest(
        inviteCode: _invitationCode,
        originAddress: locationText.value,
        originLatitude: "${_currentLocation.latitude}",
        originLongitude: "${_currentLocation.longitude}",
      );

      final success = await _gatheringRepository.enterGathering(request);
      isCompleted.value = success;
      notifyListeners();
    } on Exception catch (_) {
      isCompleted.value = false;
    }
  }
}
