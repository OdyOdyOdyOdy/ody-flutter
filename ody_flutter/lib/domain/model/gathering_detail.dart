import "package:intl/intl.dart";

class GatheringDetail {
  GatheringDetail({
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
  List<Mates>? mates;
  String? inviteCode;

  DateTime get datetime => DateFormat("yyyy-MM-dd HH:mm").parse("$date $time");

  bool get isAccessible {
    final now = DateTime.now();
    return datetime.isBefore(now.add(const Duration(minutes: 30)));
  }
}

class Mates {
  Mates({this.nickname, this.imageUrl});
  String? nickname;
  String? imageUrl;
}
