/// yyyy-MM-dd, HH:mm을 받아 yyyy-MM-dd HH:mm:ss 형식의 문자열로 반환하는 유틸 함수
String combineDateAndTimeToFullString(String date, String time) =>
    "$date ${time.padRight(5, '0')}:00";

/// 시간, 분을 받아 "HH:mm" 문자열로 반환하는 유틸 함수
String timeToString(int hour, int minute) {
  final String hourString = hour.toString().padLeft(2, "0");
  final String minuteString = minute.toString().padLeft(2, "0");
  return "$hourString:$minuteString";
}

/// 약속 시간이 30분 이내로 남았는지 확인하는 유틸 함수 (yyyy-MM-dd HH:mm:ss 형식의 문자열 지원)
bool isWithin30Minutes(String targetDateTimeString, [DateTime? now]) {
  final targetDateTime = DateTime.parse(targetDateTimeString);
  final current = now ?? DateTime.now();
  final difference = targetDateTime.difference(current);
  return difference.inMinutes >= 0 && difference.inMinutes <= 30;
}
