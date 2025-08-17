class EnterGatheringRequest {
  EnterGatheringRequest({
    this.inviteCode,
    this.originAddress,
    this.originLatitude,
    this.originLongitude,
  });

  EnterGatheringRequest.fromJson(Map<String, dynamic> json) {
    if (json["inviteCode"] is String) {
      inviteCode = json["inviteCode"];
    }
    if (json["originAddress"] is String) {
      originAddress = json["originAddress"];
    }
    if (json["originLatitude"] is String) {
      originLatitude = json["originLatitude"];
    }
    if (json["originLongitude"] is String) {
      originLongitude = json["originLongitude"];
    }
  }

  String? inviteCode;
  String? originAddress;
  String? originLatitude;
  String? originLongitude;

  static List<EnterGatheringRequest> fromList(
          List<Map<String, dynamic>> list) =>
      list.map(EnterGatheringRequest.fromJson).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["inviteCode"] = inviteCode;
    data["originAddress"] = originAddress;
    data["originLatitude"] = originLatitude;
    data["originLongitude"] = originLongitude;
    return data;
  }
}
