import "package:ody_flutter/screens/gathering_detail/model/mate.dart";

class GatheringDetail {
  GatheringDetail({
    required this.name,
    required this.dateTime,
    required this.destinationAddress,
    required this.departureAddress,
    required this.departureTime,
    required this.durationTime,
    required this.mates,
    required this.inviteCode,
  });

  final String name;
  final String dateTime;
  final String destinationAddress;
  final String departureAddress;
  final String departureTime;
  final String durationTime;
  final List<Mate> mates;
  final String inviteCode;
}
