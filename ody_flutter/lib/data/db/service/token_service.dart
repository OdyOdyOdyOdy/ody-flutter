import "package:ody_flutter/data/db/database_helper.dart";
import "package:ody_flutter/domain/model/token.dart";
import "package:sqflite/sqflite.dart";

class DeviceTokenService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertToken(Token token) async {
    final Database db = await _databaseHelper.database;
    return db.insert("token", token.toMap());
  }

  Future<Token?> fetchToken() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> result = await db.query("token", limit: 1);

    if (result.isNotEmpty) {
      final Map<String, dynamic> map = result.first;
      return Token(
        device: map["device"],
      );
    } else {
      return null;
    }
  }
}
