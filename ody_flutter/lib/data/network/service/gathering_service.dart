import "package:injectable/injectable.dart";
import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/entity/gathering/enter_gathering_request.dart";
import "package:ody_flutter/data/entity/gathering/gathering_detail_response.dart";
import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/data/entity/gathering/gathering_response.dart";
import "package:ody_flutter/data/entity/gathering/gatherings_response.dart";
import "package:ody_flutter/data/network/base/base_service.dart";

@injectable
class GatheringService {
  GatheringService(this.baseService, this.authTokenService);

  final BaseService baseService;
  final AuthTokenService authTokenService;

  Future<GatheringResponse> createGathering(GatheringRequest request) async {
    try {
      final response = await baseService.postWithResponse(
        path: "/v1/meetings",
        data: request.toJson(),
      );
      return GatheringResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<GatheringDetailResponse> fetchGathering(int id) async {
    try {
      final response = await baseService.getWithResponse(
        path: "/v2/meetings/$id",
      );
      return GatheringDetailResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<GatheringsResponse> fetchGatherings() async {
    try {
      final response = await baseService.getWithResponse(
        path: "/v1/meetings/me",
      );
      return GatheringsResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> exitMeeting(int meetingId) async {
    try {
      await baseService.deleteWithResponse(
        path: "/meetings/$meetingId/mate",
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> enterGathering(EnterGatheringRequest request) async {
    try {
      return await baseService.postWithoutResponse(
        path: "/v2/mates",
        data: request.toJson(),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> validateInvitationCode(String inviteCode) async {
    try {
      return await baseService.getWithoutResponse(
        path: "/invite-codes/$inviteCode/validate",
      );
    } catch (_) {
      rethrow;
    }
  }
}
