import "package:ody_flutter/data/entity/eta/user_eta_response.dart";
import "package:ody_flutter/domain/model/eta_status.dart";
import "package:ody_flutter/domain/model/user_eta.dart";

extension ToDomain on UserEtaResponse {
  UserEta toModel() => UserEta(
        requesterMateId: requesterMateId,
        mateEtas: mateEtas.map(_fromMateEtaResponse).toList(),
      );

  MateEta _fromMateEtaResponse(MateEtaResponse response) => MateEta(
        mateId: response.mateId,
        name: response.nickname,
        etaStatus: _mapStatus(
          response.status,
          response.durationMinutes,
        ),
        durationMinutes: response.durationMinutes,
      );

  EtaStatus _mapStatus(String status, int durationMinutes) {
    switch (status) {
      case "LATE_WARNING":
        return LateWarning(durationMinutes);
      case "ARRIVAL_SOON":
        return ArrivalSoon(durationMinutes);
      case "ARRIVED":
        return Arrived();
      case "LATE":
        return Late(durationMinutes);
      case "MISSING":
        return Missing();
      default:
        return Missing();
    }
  }
}
