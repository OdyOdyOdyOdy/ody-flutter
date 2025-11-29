class EnterGatheringResponse {
  EnterGatheringResponse({
    required this.gatheringId,
    required this.date,
    required this.time,
  });

  factory EnterGatheringResponse.fromJson(Map<String, dynamic> json) =>
      EnterGatheringResponse(
        gatheringId: json["meetingId"] as int,
        date: json["date"] as String,
        time: json["time"] as String,
      );

  final int gatheringId;
  final String date;
  final String time;
}
