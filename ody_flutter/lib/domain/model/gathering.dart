class Gathering {
  Gathering({
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
}

class Mates {
  Mates({this.nickname, this.imageUrl});
  String? nickname;
  String? imageUrl;
}
