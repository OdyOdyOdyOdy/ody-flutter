class AppleLoginRequest {
  AppleLoginRequest({
    this.deviceToken,
    this.providerId,
    this.nickname,
    this.imageUrl,
    this.authorizationCode,
  });

  String? deviceToken;
  String? providerId;
  String? nickname;
  String? imageUrl = "";
  String? authorizationCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["deviceToken"] = deviceToken;
    data["providerId"] = providerId;
    data["nickname"] = nickname;
    data["imageUrl"] = imageUrl;
    data["authorizationCode"] = authorizationCode;
    return data;
  }
}
