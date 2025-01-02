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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ody',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/gatherings': (context) => const GatheringsScreen(),
        '/gatheringCreation': (context) => const GatheringCreatorScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/invitationCode': (context) => const InvitationCodeScreen(),
        '/etaBoard': (context) => const EtaBoardScreen(),
        '/statusBoard': (context) => const StatusBoardScreen(),
      },
    );
  }
}
