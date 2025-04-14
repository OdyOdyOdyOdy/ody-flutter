class LoginResponse {
  LoginResponse({
    this.tokenType,
    this.accessToken,
    this.refreshToken,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
      tokenType = json["tokenType"];
      accessToken = json["accessToken"];
      refreshToken = json["refreshToken"];
  }

  String? tokenType;
  String? accessToken;
  String? refreshToken;
}
