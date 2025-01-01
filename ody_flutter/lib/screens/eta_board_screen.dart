import 'package:flutter/material.dart';

class EtaBoardScreen extends StatefulWidget {
  const EtaBoardScreen({super.key});

  @override
  State<EtaBoardScreen> createState() => _EtaBoardScreenState();
}

class _EtaBoardScreenState extends State<EtaBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('친구 위치 현황표 화면'));
  }
}
