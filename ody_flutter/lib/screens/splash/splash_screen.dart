import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/di/di.dart";
import "package:ody_flutter/screens/splash/splash_navigate_action.dart";
import "package:ody_flutter/screens/splash/splash_view_model.dart";

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final _viewModel = getIt<SplashViewModel>();

  @override
  Widget build(final BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 2), () async {
      await _viewModel.hasToken();

      if (context.mounted) {
        switch (_viewModel.navigation) {
          case NavigateToGatherings _:
            await Navigator.pushNamed(context, Routes.gatherings);
          case NavigateToLogin _:
            await Navigator.pushNamed(context, Routes.login);
          default:
            break;
        }
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
