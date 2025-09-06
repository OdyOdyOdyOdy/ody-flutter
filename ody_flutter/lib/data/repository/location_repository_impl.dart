import "package:injectable/injectable.dart";
import "package:ody_flutter/data/entity/mapper/location_mapper.dart";
import "package:ody_flutter/data/network/service/location_service.dart";
import "package:ody_flutter/domain/model/location.dart";
import "package:ody_flutter/domain/repository/location_repository.dart";

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(this.locationService);

  final LocationService locationService;

  @override
  Future<List<LocationModel>> searchLocation(String keyword) async {
    try {
      final response = await locationService.fetchLocation(keyword);
      return response.toModel();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<LocationModel> fetchLocationWithCoord(String x, String y) async {
    try {
      final response = await locationService.fetchLocationWithCoord(x, y);
      return response.toModel();
    } catch (_) {
      rethrow;
    }
  }
}
