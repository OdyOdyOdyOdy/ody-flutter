import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/data/entity/gathering/gathering_response.dart";
import "package:ody_flutter/data/network/base/base_service.dart";

class GatheringService {
  GatheringService(this.baseService);

  final BaseService baseService;

  Future<GatheringResponse> createGathering(GatheringRequest request) async {
    try {
      final response = await baseService.postWithResponse(
        path: "/v1/meetings",
        data: request.toJson(),
        headers: {"Authorization": "Bearer access-token={access-token}"},
      );
      return GatheringResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<GatheringResponse> fetchGathering(int id) async {
    try {
      final response = await baseService.getWithResponse(
        path: "/v1/meetings/$id",
        headers: {"Authorization": "Bearer access-token={access-token}"},
      );
      return GatheringResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
