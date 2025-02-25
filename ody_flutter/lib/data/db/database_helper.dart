import "package:ody_flutter/domain/model/token.dart";
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<int> insertToken(Token token) async {
    final Database db = await database;

    return db.insert("token", token.toMap());
  }

  Future<Token> fetchToken() async {
    final Database db = await database;

    final List<Map<String, dynamic>> result = await db.query("token", limit: 1);

    if (result.isNotEmpty) {
      final Map<String, dynamic> map = result.first;
      return Token(
        device: map["device"],
      );
    } else {
      throw Exception("Token not found");
    }
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), "token.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
        CREATE TABLE token(
          device TEXT
        )
        """);
      },
    );
  }
}
