import "package:flutter/material.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });

    return const Scaffold(
      body: Center(child: Text("스플래쉬 화면")),
    );
  }
}
