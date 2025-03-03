import "package:ody_flutter/domain/model/token.dart";

abstract class TokenRepository {
  Future<void> addToken();
  Future<Token?> getToken();
}
