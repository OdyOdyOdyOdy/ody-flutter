import "package:flutter/cupertino.dart";
import "package:ody_flutter/screens/eta_board/eta_board_screen.dart";
import "package:ody_flutter/screens/gathering_creator/gathering_creator_screen.dart";
import "package:ody_flutter/screens/gathering_creator/screens/gathering_location_search_screen.dart";
import "package:ody_flutter/screens/gathering_detail/gathering_detail_screen.dart";
import "package:ody_flutter/screens/gathering_enter/gathering_enter_complete_screen.dart";
import "package:ody_flutter/screens/gathering_enter/gathering_enter_location_screen.dart";
import "package:ody_flutter/screens/gatherings/gatherings_screen.dart";
import "package:ody_flutter/screens/invitation_code/invitation_code_screen.dart";
import "package:ody_flutter/screens/login/login_screen.dart";
import "package:ody_flutter/screens/settings/settings_screen.dart";
import "package:ody_flutter/screens/splash/splash_screen.dart";
import "package:ody_flutter/screens/status_board/status_board_screen.dart";

Map<String, WidgetBuilder> namedRoutes = <String, WidgetBuilder>{
  "/splash": (final BuildContext context) => SplashScreen(),
  "/login": (final BuildContext context) => const LoginScreen(),
  "/gatherings": (final BuildContext context) => const GatheringsScreen(),
  "/gatheringCreation": (final BuildContext context) =>
      GatheringCreatorScreen(),
  "/gatheringDetail": (final BuildContext context) =>
      const GatheringDetailScreen(),
  "/settings": (final BuildContext context) => const SettingsScreen(),
  "/invitationCode": (final BuildContext context) => InvitationCodeScreen(),
  "/etaBoard": (final BuildContext context) => const EtaBoardScreen(),
  "/statusBoard": (final BuildContext context) => const StatusBoardScreen(),
  "/gatheringLocationSearch": (final BuildContext context) =>
      GatheringLocationSearchScreen(),
  "/gatheringEnter": (final BuildContext context) => GatheringEnterScreen(),
  "/gatheringEnterComplete": (final BuildContext context) =>
      const GatheringEnterCompleteScreen(),
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
  static const String gatheringLocationSearch = "/gatheringLocationSearch";
  static const String gatheringEnter = "/gatheringEnter";
  static const String gatheringEnterComplete = "/gatheringEnterComplete";
}
