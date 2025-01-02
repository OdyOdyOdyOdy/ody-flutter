import "package:flutter/material.dart";

class InvitationCodeScreen extends StatefulWidget {
  const InvitationCodeScreen({super.key});

  @override
  State<InvitationCodeScreen> createState() => _InvitationCodeScreenState();
}

class _InvitationCodeScreenState extends State<InvitationCodeScreen> {
  @override
  Widget build(final BuildContext context) =>
      const Center(child: Text("초대 코드 화면"));
}
