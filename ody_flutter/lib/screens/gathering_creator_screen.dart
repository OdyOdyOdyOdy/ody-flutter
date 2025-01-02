import "package:flutter/material.dart";

class GatheringCreatorScreen extends StatefulWidget {
  const GatheringCreatorScreen({super.key});

  @override
  State<GatheringCreatorScreen> createState() => _GatheringCreatorScreenState();
}

class _GatheringCreatorScreenState extends State<GatheringCreatorScreen> {
  @override
  Widget build(BuildContext context) => const Center(child: Text("약속 생성 화면"));
}
