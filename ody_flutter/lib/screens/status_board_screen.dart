import "package:flutter/material.dart";

class StatusBoardScreen extends StatefulWidget {
  const StatusBoardScreen({super.key});

  @override
  State<StatusBoardScreen> createState() => _StatusBoardScreenState();
}

class _StatusBoardScreenState extends State<StatusBoardScreen> {
  @override
  Widget build(BuildContext context) => const Center(child: Text("상태 현황표 화면"));
}
