import "package:injectable/injectable.dart";
import "package:ody_flutter/data/entity/eta/user_eta_request.dart";
import "package:ody_flutter/data/entity/eta/user_eta_response.dart";
import "package:ody_flutter/data/network/base/base_service.dart";

@singleton
class EtaService {
  EtaService(this._baseService);

  final BaseService _baseService;

  Future<UserEtaResponse> patchEtaBoard(
    int meetingId,
    EtaRequest request,
  ) async {
    final response = await _baseService.patchWithResponse(
      path: "/v2/meetings/$meetingId/mates/etas",
      data: request.toJson(),
    );
    return UserEtaResponse.fromJson(response);
  }
}
