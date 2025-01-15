import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/images/images.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        await Navigator.pushReplacementNamed(context, "/login");
      }
    });

    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: CommonColors.purple_800,
          child: Center(child: SvgPicture.asset(CommonImages.icSplashLogo))),
    );
  }
}
