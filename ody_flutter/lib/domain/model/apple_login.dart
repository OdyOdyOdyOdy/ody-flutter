class AppleLogin {
  AppleLogin({
    this.deviceToken,
    this.providerId,
    this.nickname,
    this.imageUrl,
    this.authorizationCode,
  });

  String? deviceToken;
  String? providerId;
  String? nickname;
  String? imageUrl;
  String? authorizationCode;
}
