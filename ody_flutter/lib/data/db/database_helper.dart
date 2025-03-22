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

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), "ody.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute("""
        CREATE TABLE device_token(
          device TEXT
        )
        """);

        await db.execute("""
        CREATE TABLE auth_token(
          accessToken TEXT,
          refreshToken TEXT
        )
        """);
      },
    );
  }
}
