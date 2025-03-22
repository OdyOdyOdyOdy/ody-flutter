class LoginResponse {
  LoginResponse({
    this.tokenType,
    this.accessToken,
    this.refreshToken,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json["tokenType"] is String) {
      tokenType = json["tokenType"];
    }
    if (json["accessToken"] is String) {
      accessToken = json["accessToken"];
    }
    if (json["refreshToken"] is String) {
      refreshToken = json["refreshToken"];
    }
  }

  String? tokenType;
  String? accessToken;
  String? refreshToken;
}
