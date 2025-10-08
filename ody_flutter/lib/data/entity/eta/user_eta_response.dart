class UserEtaResponse {
  UserEtaResponse({
    required this.requesterMateId,
    required this.mateEtas,
  });

  factory UserEtaResponse.fromJson(Map<String, dynamic> json) =>
      UserEtaResponse(
        requesterMateId: json["requesterMateId"],
        mateEtas: (json["mateEtas"] as List)
            .map((e) => MateEtaResponse.fromJson(e))
            .toList(),
      );

  final int requesterMateId;
  final List<MateEtaResponse> mateEtas;
}

class MateEtaResponse {
  MateEtaResponse({
    required this.mateId,
    required this.nickname,
    required this.status,
    required this.durationMinutes,
  });

  factory MateEtaResponse.fromJson(Map<String, dynamic> json) =>
      MateEtaResponse(
        mateId: json["mateId"],
        nickname: json["nickname"],
        status: json["status"],
        durationMinutes: json["durationMinutes"],
      );

  final int mateId;
  final String nickname;
  final String status;
  final int durationMinutes;
}
