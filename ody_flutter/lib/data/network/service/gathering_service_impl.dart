import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/data/entity/gathering/gathering_response.dart";
import "package:ody_flutter/data/entity/gathering/gatherings_response.dart";
import "package:ody_flutter/data/network/base/base_service.dart";

class GatheringService {
  GatheringService(this.baseService, this.authTokenService);

  final BaseService baseService;
  final AuthTokenService authTokenService;

  Future<GatheringResponse> createGathering(GatheringRequest request) async {
    try {
      final token = await authTokenService.getToken();
      final response = await baseService.postWithResponse(
        path: "/v1/meetings",
        data: request.toJson(),
        headers: {"Authorization": "Bearer access-token=${token?.accessToken}"},
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

  Future<GatheringsResponse> fetchGatherings(
    Map<String, dynamic> headers,
  ) async {
    try {
      final response = await baseService.getWithResponse(
        path: "/v1/meetings/me",
        headers: headers,
      );
      return GatheringsResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
