class GatheringRequest {
  GatheringRequest({
    this.name,
    this.date,
    this.time,
    this.targetAddress,
    this.targetLatitude,
    this.targetLongitude,
  });

  GatheringRequest.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["time"] is String) {
      time = json["time"];
    }
    if (json["targetAddress"] is String) {
      targetAddress = json["targetAddress"];
    }
    if (json["targetLatitude"] is String) {
      targetLatitude = json["targetLatitude"];
    }
    if (json["targetLongitude"] is String) {
      targetLongitude = json["targetLongitude"];
    }
  }

  String? name;
  String? date;
  String? time;
  String? targetAddress;
  String? targetLatitude;
  String? targetLongitude;

  static List<GatheringRequest> fromList(List<Map<String, dynamic>> list) =>
      list.map(GatheringRequest.fromJson).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["date"] = date;
    data["time"] = time;
    data["targetAddress"] = targetAddress;
    data["targetLatitude"] = targetLatitude;
    data["targetLongitude"] = targetLongitude;
    return data;
  }
}
