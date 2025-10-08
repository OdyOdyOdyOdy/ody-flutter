import "package:ody_flutter/domain/model/eta_status.dart";

class UserEta {
  UserEta({
    required this.requesterMateId,
    required this.mateEtas,
  });

  final int requesterMateId;
  final List<MateEta> mateEtas;
}

class MateEta {
  MateEta({
    required this.mateId,
    required this.name,
    required this.etaStatus,
    required this.durationMinutes,
  });

  final int mateId;
  final String name;
  final EtaStatus etaStatus;
  final int durationMinutes;
}
