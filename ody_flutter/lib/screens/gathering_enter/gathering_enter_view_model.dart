import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";
import "package:location/location.dart";
import "package:ody_flutter/domain/model/gathering.dart";

@injectable
class GatheringEnterViewModel extends ChangeNotifier {
  GatheringEnterViewModel();

  Gathering? gathering;
  final ValueNotifier<String> locationText = ValueNotifier("");
  final ValueNotifier<bool> isConfirmEnabled = ValueNotifier(false);

  Future<void> fetchCurrentLocation() async {
    final Location location = Location();
    await location.getLocation().then((final LocationData locationData) {
      locationText.value =
          "${locationData.latitude}, ${locationData.longitude}";
      isConfirmEnabled.value = true;
      notifyListeners();
    });
  }
}
