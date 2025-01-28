class Gathering {
  Gathering({
    required this.name,
    required this.date,
    required this.time,
    required this.targetAddress,
    required this.originAddress,
    required this.durationMinutes,
  });

  final String name;
  final String date;
  final String time;
  final String targetAddress;
  final String originAddress;
  final String durationMinutes;
  bool isExpanded = false;
  bool isTimeToEta = false;
}
