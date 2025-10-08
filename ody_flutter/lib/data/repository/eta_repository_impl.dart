import "package:injectable/injectable.dart";
import "package:ody_flutter/data/entity/eta/user_eta_request.dart";
import "package:ody_flutter/data/entity/mapper/user_eta_mapper.dart";
import "package:ody_flutter/data/network/service/eta_service.dart";
import "package:ody_flutter/domain/model/user_eta.dart";
import "package:ody_flutter/domain/repository/eta_repository.dart";

@LazySingleton(as: EtaRepository)
class EtaRepositoryImpl implements EtaRepository {
  EtaRepositoryImpl(this._etaService);

  final EtaService _etaService;

  @override
  Future<UserEta> patchEtaBoard({
    required int meetingId,
    required EtaRequest request,
  }) async {
    final response = await _etaService.patchEtaBoard(meetingId, request);
    return response.toModel();
  }
}
