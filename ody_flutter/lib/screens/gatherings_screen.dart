import "package:flutter/material.dart";
import "package:ody_flutter/config/routes.dart";

class GatheringsScreen extends StatefulWidget {
  const GatheringsScreen({super.key});

  @override
  State<GatheringsScreen> createState() => _GatheringsScreenState();
}

class _GatheringsScreenState extends State<GatheringsScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.settings);
              },
              child: const Text("설정"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.gatheringCreation);
              },
              child: const Text("약속 생성"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.invitationCode);
              },
              child: const Text("초대 코드"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.etaBoard);
              },
              child: const Text("친구 현황표"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.statusBoard);
              },
              child: const Text("상태 현황표"),
            ),
          ],
        ),
      );
}
