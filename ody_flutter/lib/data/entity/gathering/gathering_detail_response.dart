class GatheringDetailResponse {
  GatheringDetailResponse({
    this.id,
    this.name,
    this.date,
    this.time,
    this.departureTime,
    this.routeTime,
    this.originAddress,
    this.targetAddress,
    this.targetLatitude,
    this.targetLongitude,
    this.mateCount,
    this.mates,
    this.inviteCode,
  });

  GatheringDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["time"] is String) {
      time = json["time"];
    }
    if (json["departureTime"] is String) {
      departureTime = json["departureTime"];
    }
    if (json["routeTime"] is int) {
      routeTime = json["routeTime"];
    }
    if (json["originAddress"] is String) {
      originAddress = json["originAddress"];
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
    if (json["mateCount"] is int) {
      mateCount = json["mateCount"];
    }
    if (json["mates"] is List) {
      mates = json["mates"] == null
          ? null
          : (json["mates"] as List)
              .map((e) => ResponseMates.fromJson(e))
              .toList();
    }
    if (json["inviteCode"] is String) {
      inviteCode = json["inviteCode"];
    }
  }

  int? id;
  String? name;
  String? date;
  String? time;
  String? departureTime;
  int? routeTime;
  String? originAddress;
  String? targetAddress;
  String? targetLatitude;
  String? targetLongitude;
  int? mateCount;
  List<ResponseMates>? mates;
  String? inviteCode;
}

class ResponseMates {
  ResponseMates({this.nickname, this.imageUrl});

  ResponseMates.fromJson(Map<String, dynamic> json) {
    if (json["nickname"] is String) {
      nickname = json["nickname"];
    }
    if (json["imageUrl"] is String) {
      imageUrl = json["imageUrl"];
    }
  }

  String? nickname;
  String? imageUrl;

  static List<ResponseMates> fromList(List<Map<String, dynamic>> list) =>
      list.map(ResponseMates.fromJson).toList();
}
