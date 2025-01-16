import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/config/routes.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        await Navigator.pushReplacementNamed(context, Routes.login);
      }
    });

    return Scaffold(
      backgroundColor: CommonColors.purple_800,
      body: Center(
          child: SvgPicture.asset(CommonImages.icSplashLogo),
        ),
    );
  }
}
