import "package:ody_flutter/assets/images/images.dart";

enum UseOfServiceType {
  privacyPolicy,
  term,
  logout,
  withdraw;
}

enum UseOfServiceSetting {
  privacyPolicy(
    CommonImages.icUserInfo,
    "개인정보 처리 방침",
    UseOfServiceType.privacyPolicy,
  ),
  term(
    CommonImages.icCommentInfo,
    "서비스 이용 약관",
    UseOfServiceType.term,
  ),
  logout(
    CommonImages.icLogout,
    "로그아웃",
    UseOfServiceType.logout,
  ),
  withdraw(
    CommonImages.icUserClose,
    "회원 탈퇴",
    UseOfServiceType.withdraw,
  );

  const UseOfServiceSetting(this.icon, this.description, this.useOfServiceType);

  final String icon;
  final String description;
  final UseOfServiceType useOfServiceType;
}
