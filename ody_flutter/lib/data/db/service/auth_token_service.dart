import "package:ody_flutter/data/db/database_helper.dart";
import "package:ody_flutter/domain/model/auth_token.dart";
import "package:sqflite/sqflite.dart";

class AuthTokenService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> saveToken(AuthToken authToken) async {
    final Database db = await _databaseHelper.database;
    return db.insert("auth_token", authToken.toMap());
  }

  Future<AuthToken?> getToken() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      "auth_token",
      limit: 1,
    );

    if (result.isNotEmpty) {
      final Map<String, dynamic> map = result.first;
      return AuthToken(
        accessToken: map["accessToken"],
        refreshToken: map["refreshToken"],
      );
    } else {
      return null;
    }
  }
}
