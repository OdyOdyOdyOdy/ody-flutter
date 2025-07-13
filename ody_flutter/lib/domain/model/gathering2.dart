import "package:intl/intl.dart";

class Gathering2 {

  Gathering2({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.targetAddress,
    required this.originAddress,
    required this.durationMinutes,
    this.mateCount,
  });

  int id;
  String name;
  int? mateCount;
  String date;
  String time;
  String targetAddress;
  String originAddress;
  int durationMinutes;
  bool isExpanded = false;
  bool isTimeToEta = false;

  DateTime get datetime => DateFormat("yyyy-MM-dd HH:mm").parse("$date $time");

  bool get isAccessible {
    final now = DateTime.now();
    return datetime.isAfter(now.add(const Duration(minutes: 30)));
  }

  String dateTimeMessage() {
    final now = DateTime.now();
    final meetingDate = datetime;
    final localDate = DateTime(meetingDate.year, meetingDate.month, meetingDate.day);
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    if (localDate == today) {
      return "오늘 ${_formatTime(meetingDate)}";
    } else if (localDate == tomorrow) {
      return "내일 ${_formatTime(meetingDate)}";
    } else if (_isWithinNextWeek(localDate, today)) {
      final daysDiff = localDate.difference(today).inDays;
      return "$daysDiff일 후";
    } else {
      return DateFormat("yyyy년 M월 d일").format(localDate);
    }
  }

  String get formattedDate {
    final parsedDate = DateFormat("yyyy-MM-dd").parse(date);
    return DateFormat("yyyy년 M월 d일", "ko_KR").format(parsedDate);
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour;
    final minute = dt.minute;

    final isAm = hour < 12;
    final amPm = isAm ? "오전" : "오후";

    final hour12 = hour % 12 == 0 ? 12 : hour % 12;

    if (minute == 0) {
      return "$amPm $hour12시";
    } else {
      return "$amPm $hour12시 $minute분";
    }
  }

  bool _isWithinNextWeek(DateTime date, DateTime today) {
    final diff = date.difference(today).inDays;
    return diff >= 2 && diff <= 7;
  }
}
