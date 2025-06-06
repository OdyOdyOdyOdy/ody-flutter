import "dart:async";

import "package:flutter/cupertino.dart";
import "package:ody_flutter/domain/model/location.dart";
import "package:ody_flutter/domain/repository/location_repository.dart";

class GatheringLocationViewModel extends ChangeNotifier {
  GatheringLocationViewModel(this.locationRepository) {
    _init();
  }

  final LocationRepository locationRepository;

  final ValueNotifier<String> text = ValueNotifier("");

  List<LocationModel> locationList = [];

  Timer _debounceTimer = Timer(Duration.zero, () {});

  void _init() {
    text.addListener(() async {
      await _searchLocation(text.value);
    });
  }

  Future<void> _searchLocation(String keyword) async {
    if (_debounceTimer.isActive) {
      _debounceTimer.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (keyword.isNotEmpty) {
        locationList = await locationRepository.searchLocation(keyword);
      } else {
        locationList = [];
      }
      notifyListeners();
    });
  }
}
