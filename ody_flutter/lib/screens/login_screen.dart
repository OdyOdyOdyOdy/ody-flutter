import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, "/gatherings");
          },
          child: const Text("로그인"),
        ),
      ),
    );
}
