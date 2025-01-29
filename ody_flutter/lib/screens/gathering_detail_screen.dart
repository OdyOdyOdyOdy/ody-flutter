import "package:flutter/material.dart";

class GatheringDetailScreen extends StatefulWidget {
  const GatheringDetailScreen({super.key});

  @override
  State<GatheringDetailScreen> createState() => _GatheringDetailScreenState();
}

class _GatheringDetailScreenState extends State<GatheringDetailScreen> {
  @override
  Widget build(final BuildContext context) =>
      const Center(child: Text("약속 상세 화면"));
}
