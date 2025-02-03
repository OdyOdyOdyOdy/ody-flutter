class GatheringResponse {
  GatheringResponse({
    this.id,
    this.name,
    this.date,
    this.time,
    this.targetAddress,
    this.targetLatitude,
    this.targetLongitude,
    this.mateCount,
    this.mates,
    this.inviteCode,
  });

  GatheringResponse.fromJson(Map<String, dynamic> json) {
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
          : (json["mates"] as List).map((e) => Mates.fromJson(e)).toList();
    }
    if (json["inviteCode"] is String) {
      inviteCode = json["inviteCode"];
    }
  }

  int? id;
  String? name;
  String? date;
  String? time;
  String? targetAddress;
  String? targetLatitude;
  String? targetLongitude;
  int? mateCount;
  List<Mates>? mates;
  String? inviteCode;

  static List<GatheringResponse> fromList(List<Map<String, dynamic>> list) =>
      list.map(GatheringResponse.fromJson).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["date"] = date;
    data["time"] = time;
    data["targetAddress"] = targetAddress;
    data["targetLatitude"] = targetLatitude;
    data["targetLongitude"] = targetLongitude;
    data["mateCount"] = mateCount;
    if (mates != null) {
      data["mates"] = mates?.map((e) => e.toJson()).toList();
    }
    data["inviteCode"] = inviteCode;
    return data;
  }
}

class Mates {
  Mates({this.nickname, this.imageUrl});
  Mates.fromJson(Map<String, dynamic> json) {
    if (json["nickname"] is String) {
      nickname = json["nickname"];
    }
    if (json["imageUrl"] is String) {
      imageUrl = json["imageUrl"];
    }
  }
  String? nickname;
  String? imageUrl;

  static List<Mates> fromList(List<Map<String, dynamic>> list) =>
      list.map(Mates.fromJson).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["nickname"] = nickname;
    data["imageUrl"] = imageUrl;
    return data;
  }
}
