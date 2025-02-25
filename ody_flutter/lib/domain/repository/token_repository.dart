import "package:ody_flutter/domain/model/token.dart";

abstract class TokenRepository {
  Future<void> insertToken();
  Future<Token?> getToken();
}
