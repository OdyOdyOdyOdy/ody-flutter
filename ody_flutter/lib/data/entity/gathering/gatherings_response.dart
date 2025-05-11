class GatheringsResponse {
  GatheringsResponse({required this.meetings});

  factory GatheringsResponse.fromJson(Map<String, dynamic> json) =>
      GatheringsResponse(
        meetings: (json["meetings"] as List)
            .map((item) => Meeting.fromJson(item))
            .toList(),
      );
  final List<Meeting> meetings;

  Map<String, dynamic> toJson() => {
        "meetings": meetings.map((meeting) => meeting.toJson()).toList(),
      };
}

class Meeting {
  Meeting({
    required this.id,
    required this.name,
    required this.mateCount,
    required this.date,
    required this.time,
    required this.targetAddress,
    required this.originAddress,
    required this.durationMinutes,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        id: json["id"],
        name: json["name"],
        mateCount: json["mateCount"],
        date: json["date"],
        time: json["time"],
        targetAddress: json["targetAddress"],
        originAddress: json["originAddress"],
        durationMinutes: json["durationMinutes"],
      );
  final int id;
  final String name;
  final int mateCount;
  final String date;
  final String time;
  final String targetAddress;
  final String originAddress;
  final int durationMinutes;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mateCount": mateCount,
        "date": date,
        "time": time,
        "targetAddress": targetAddress,
        "originAddress": originAddress,
        "durationMinutes": durationMinutes,
      };
}
