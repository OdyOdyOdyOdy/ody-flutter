import "package:ody_flutter/data/db/database_helper.dart";
import "package:ody_flutter/domain/model/device_token.dart";
import "package:sqflite/sqflite.dart";

class DeviceTokenService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> addToken(DeviceToken token) async {
    final Database db = await _databaseHelper.database;
    return db.insert("device_token", token.toMap());
  }

  Future<DeviceToken?> fetchToken() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      "device_token",
      limit: 1,
    );

    if (result.isNotEmpty) {
      final Map<String, dynamic> map = result.first;
      return DeviceToken(
        device: map["device"],
      );
    } else {
      return null;
    }
  }
}
