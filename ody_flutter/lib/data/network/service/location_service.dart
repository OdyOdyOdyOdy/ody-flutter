import "package:flutter/cupertino.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/data/entity/gathering/location_response.dart";
import "package:ody_flutter/data/entity/gathering/location_response_with_string.dart";
import "package:ody_flutter/data/network/base/base_service.dart";

@injectable
class LocationService {
  LocationService(this.baseService);

  final BaseService baseService;

  Future<LocationResponseWithString> fetchLocation(String keyword) async {
    try {
      final response = await baseService.getWithResponse(
        url:
            "https://dapi.kakao.com/v2/local/search/keyword.json?query=$keyword&page=1&size=15",
        headers: {"Authorization": "KakaoAK ${dotenv.get("KAKAO_API_KEY")}"},
      );
      return LocationResponseWithString.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<LocationResponse> fetchLocationWithCoord(
    String x,
    String y,
  ) async {
    try {
      final response = await baseService.getWithResponse(
        url:
            "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$x&y=$y",
        headers: {"Authorization": "KakaoAK ${dotenv.get("KAKAO_API_KEY")}"},
      );
      debugPrint('response: $response');
      debugPrint('fromjson: ${LocationResponse.fromJson(response)}');
      return LocationResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
