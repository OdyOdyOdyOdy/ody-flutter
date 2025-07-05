import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:jwt_decoder/jwt_decoder.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/db/service/device_token_service.dart";
import "package:ody_flutter/data/network/base/base_service.dart";
import "package:ody_flutter/data/network/service/auth_service.dart";
import "package:ody_flutter/data/repository/auth_repository_impl.dart";
import "package:ody_flutter/data/repository/device_token_repository_impl.dart";
import "package:ody_flutter/screens/login/login_navigate_action.dart";
import "package:ody_flutter/screens/login/login_view_model.dart";
import "package:sign_in_with_apple/sign_in_with_apple.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginViewModel(
      AuthRepositoryImpl(
        AuthService(BaseService(AuthTokenService())),
        AuthTokenService(),
      ),
      DeviceTokenRepositoryImpl(DeviceTokenService()),
    );
    _viewModel.navigation.addListener(_onNavigationChanged);
    unawaited(_viewModel.requestPermission());
  }

  Future<void> _onNavigationChanged() async {
    final action = _viewModel.navigation.value;
    if (action != null) {
      if (action is NavigateToGatherings) {
        await Navigator.pushReplacementNamed(context, Routes.gatherings);
      }
    }
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: CommonColors.cream,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _topContent(),
              Padding(
                padding: const EdgeInsets.only(left: 21, bottom: 25, right: 21),
                child: SignInWithAppleButton(
                  onPressed: _appleLogin,
                  text: "Apple로 로그인",
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> _appleLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final decodedToken = JwtDecoder.decode(credential.identityToken!);

    if (credential.familyName == null || credential.givenName == null) {
      await _viewModel.login(
        decodedToken["sub"],
        "",
        credential.authorizationCode,
      );
    } else {
      await _viewModel.login(
        decodedToken["sub"],
        "${credential.familyName}${credential.givenName}",
        credential.authorizationCode,
      );
    }
  }

  Widget _topContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 127), // 상단 패딩 적용
          Padding(
            padding: const EdgeInsets.only(left: 46),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "애플로그인으로\n간편하게 ",
                    style: PretendardFonts.bold24
                        .copyWith(color: CommonColors.black),
                  ),
                  TextSpan(
                    text: "오디 ",
                    style: PretendardFonts.bold24
                        .copyWith(color: CommonColors.purple_800),
                  ),
                  TextSpan(
                    text: "시작하기",
                    style: PretendardFonts.bold24
                        .copyWith(color: CommonColors.black),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 39),
          Center(child: SvgPicture.asset(CommonImages.icHappyOdy)),
        ],
      );
}
