import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:ody_flutter/data/db/DatabaseHelper.dart";
import "package:ody_flutter/domain/model/token.dart";
import "package:ody_flutter/domain/repository/token_repository.dart";

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl(this.db);

  final DatabaseHelper db;

  @override
  Future<Token?> getToken() async {
    try {
      return await db.fetchToken();
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<int> insertToken() async {
    final String? deviceToken = await FirebaseMessaging.instance.getToken();
    return db.insertToken(Token(device: deviceToken));
  }
}
