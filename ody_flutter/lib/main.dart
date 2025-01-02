import "package:flutter/material.dart";

import "package:ody_flutter/screens/eta_board_screen.dart";
import "package:ody_flutter/screens/gathering_creator_screen.dart";
import "package:ody_flutter/screens/gatherings_screen.dart";
import "package:ody_flutter/screens/invitation_code_screen.dart";
import "package:ody_flutter/screens/login_screen.dart";
import "package:ody_flutter/screens/settings_screen.dart";
import "package:ody_flutter/screens/splash_screen.dart";
import "package:ody_flutter/screens/status_board_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ody",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/splash",
      routes: <String, WidgetBuilder>{
        "/splash": (final BuildContext context) => const SplashScreen(),
        "/login": (final BuildContext context) => const LoginScreen(),
        "/gatherings": (final BuildContext context) => const GatheringsScreen(),
        "/gatheringCreation": (final BuildContext context) => const GatheringCreatorScreen(),
        "/settings": (final BuildContext context) => const SettingsScreen(),
        "/invitationCode": (final BuildContext context) => const InvitationCodeScreen(),
        "/etaBoard": (final BuildContext context) => const EtaBoardScreen(),
        "/statusBoard": (final BuildContext context) => const StatusBoardScreen(),
      },
    );
}
