class AuthToken {
  AuthToken({
    this.accessToken,
    this.refreshToken,
  });

  String? accessToken;
  String? refreshToken;

  Map<String, dynamic> toMap() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
