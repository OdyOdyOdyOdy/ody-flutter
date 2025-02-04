import "package:flutter/cupertino.dart";
import "package:ody_flutter/screens/eta_board_screen.dart";
import "package:ody_flutter/screens/gathering_detail/gathering_detail_screen.dart";
import "package:ody_flutter/screens/gatherings/gathering_creator_screen.dart";
import "package:ody_flutter/screens/gatherings/gatherings_screen.dart";
import "package:ody_flutter/screens/invitation_code_screen.dart";
import "package:ody_flutter/screens/login_screen.dart";
import "package:ody_flutter/screens/settings/settings_screen.dart";
import "package:ody_flutter/screens/splash_screen.dart";
import "package:ody_flutter/screens/status_board/status_board_screen.dart";

Map<String, WidgetBuilder> namedRoutes = <String, WidgetBuilder>{
  "/splash": (final BuildContext context) => const SplashScreen(),
  "/login": (final BuildContext context) => const LoginScreen(),
  "/gatherings": (final BuildContext context) => const GatheringsScreen(),
  "/gatheringCreation": (final BuildContext context) =>
      GatheringCreatorScreen(),
  "/gatheringDetail": (final BuildContext context) =>
      const GatheringDetailScreen(),
  "/settings": (final BuildContext context) => const SettingsScreen(),
  "/invitationCode": (final BuildContext context) =>
      const InvitationCodeScreen(),
  "/etaBoard": (final BuildContext context) => const EtaBoardScreen(),
  "/statusBoard": (final BuildContext context) => const StatusBoardScreen(),
};

class Routes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String gatherings = "/gatherings";
  static const String gatheringCreation = "/gatheringCreation";
  static const String gatheringDetail = "/gatheringDetail";
  static const String settings = "/settings";
  static const String invitationCode = "/invitationCode";
  static const String etaBoard = "/etaBoard";
  static const String statusBoard = "/statusBoard";
}
