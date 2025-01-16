import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/config/routes.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: CommonColors.cream,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _topContent(),
              _appleLoginButton(context),
            ],
          ),
        ),
      );

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

  Widget _appleLoginButton(final BuildContext context) => GestureDetector(
        onTap: () async => Navigator.pushNamed(context, Routes.gatherings),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 21, right: 21, bottom: 25),
          child: FittedBox(
            fit: BoxFit.fill,
            child: SvgPicture.asset(CommonImages.icAppleLogin),
          ),
        ),
      );
}
