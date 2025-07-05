import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";
import "package:location/location.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/repository/location_repository.dart";

@injectable
class GatheringEnterViewModel extends ChangeNotifier {
  GatheringEnterViewModel(this._locationRepository);

  final LocationRepository _locationRepository;

  Gathering? gathering;
  final ValueNotifier<String> locationText = ValueNotifier("");
  final ValueNotifier<bool> isConfirmEnabled = ValueNotifier(false);

  Future<void> fetchCurrentLocation() async {
    final Location location = Location();

    await location.getLocation().then((final LocationData locationData) async {
      final currentLocation = await _locationRepository.fetchLocationWithCoord(
        "${locationData.longitude}",
        "${locationData.latitude}",
      );
      locationText.value = "${currentLocation.name}";
      isConfirmEnabled.value = true;
      notifyListeners();
    });
  }
}
