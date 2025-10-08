import "package:flutter/foundation.dart";
import "package:location/location.dart";

final Location _location = Location();

Future<LocationData?> getCurrentLocation() async {
  bool serviceEnabled = await _location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await _location.requestService();
    if (!serviceEnabled) {
      debugPrint("[Location] 위치 서비스가 활성화되지 않았습니다.");
      return null;
    }
  }

  PermissionStatus permissionGranted = await _location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await _location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      debugPrint("[Location] 위치 권한이 거부되었습니다.");
      return null;
    }
  }

  try {
    debugPrint("[Location] 현재 위치를 가져오는 중...");
    return await _location.getLocation();
  } on Exception catch (e) {
    debugPrint("[Location] 위치 정보를 가져오는 데 실패했습니다: $e");
    return null;
  }
}
