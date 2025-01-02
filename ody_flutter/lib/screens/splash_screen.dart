import "package:flutter/material.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        await Navigator.pushReplacementNamed(context, "/login");
      }
    });

    return const Scaffold(
      body: Center(child: Text("스플래쉬 화면")),
    );
  }
}
