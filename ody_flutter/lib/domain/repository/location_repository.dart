import "package:ody_flutter/domain/model/location.dart";

abstract class LocationRepository {
  Future<List<LocationModel>> searchLocation(String keyword);
}
