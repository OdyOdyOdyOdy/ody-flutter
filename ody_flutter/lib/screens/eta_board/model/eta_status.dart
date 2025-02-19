import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";

sealed class EtaStatus {
  String statusMessage();

  Color get color;
  String get badgeMessage;
}

class Arrived extends EtaStatus {
  Arrived();

  @override
  String statusMessage() => "-";

  @override
  Color get color => CommonColors.blue;

  @override
  String get badgeMessage => "도착";
}

class ArrivalSoon extends EtaStatus {
  ArrivalSoon(this.durationMinutes);

  final int durationMinutes;

  @override
  String statusMessage() => "$durationMinutes분 내 도착";

  @override
  Color get color => CommonColors.green;

  @override
  String get badgeMessage => "도착 예정";
}

class LateWarning extends EtaStatus {
  LateWarning(this.durationMinutes);

  final int durationMinutes;

  @override
  String statusMessage() => "$durationMinutes분 후 도착";

  @override
  Color get color => CommonColors.yellow;

  @override
  String get badgeMessage => "지각 위기";
}

class Late extends EtaStatus {
  Late(this.durationMinutes);

  final int durationMinutes;

  @override
  String statusMessage() => "$durationMinutes분 후 도착";

  @override
  Color get color => CommonColors.red;

  @override
  String get badgeMessage => "지각";
}

class Missing extends EtaStatus {
  Missing();

  @override
  String statusMessage() => "오디";

  @override
  Color get color => CommonColors.gray_400;

  @override
  String get badgeMessage => "행방불명";
}
