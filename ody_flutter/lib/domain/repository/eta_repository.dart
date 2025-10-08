import "package:ody_flutter/data/entity/eta/user_eta_request.dart";
import "package:ody_flutter/domain/model/user_eta.dart";

abstract class EtaRepository {
  Future<UserEta> patchEtaBoard({
    required int meetingId,
    required EtaRequest request,
  });
}
