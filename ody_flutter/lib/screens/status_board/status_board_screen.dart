import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_alert.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/screens/status_board/model/user_notification_type.dart";
import "package:ody_flutter/screens/status_board/model/user_status.dart";

class StatusBoardScreen extends StatefulWidget {
  const StatusBoardScreen({super.key});

  @override
  State<StatusBoardScreen> createState() => _StatusBoardScreenState();
}

class _StatusBoardScreenState extends State<StatusBoardScreen> {
  // 추후에 서버 api 연결
  final List<UserStatus> userStatuses = [
    UserStatus(
      nickname: "김영인",
      created: "2024-07-11 2:30",
      imageUrl: "https://picsum.photos/250?image=1",
      userNotificationType: UserNotificationType.entry,
    ),
    UserStatus(
      nickname: "장원영",
      created: "2024-07-11 2:30",
      imageUrl: "https://picsum.photos/250?image=2",
      userNotificationType: UserNotificationType.departure,
    ),
    UserStatus(
      nickname: "카리나",
      created: "2024-07-11 2:30",
      imageUrl: "https://picsum.photos/250?image=3",
      userNotificationType: UserNotificationType.memberDeletion,
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: _buildFloatingActionButton(context),
        backgroundColor: CommonColors.cream,
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 24),
              _buildStatusList(),
            ],
          ),
        ),
      );

  Widget _buildFloatingActionButton(BuildContext context) => SizedBox(
        width: 86,
        height: 37,
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.pushNamed(context, Routes.etaBoard);
          },
          backgroundColor: CommonColors.purple_800,
          label: Text(
            "오디?",
            style: PretendardFonts.bold16.copyWith(color: CommonColors.white),
          ),
          icon: SvgPicture.asset(CommonImages.icOdy),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );

  Widget _buildTopBar(BuildContext context) => OdyTopBar(
        title: "어쩌구약속이름어쩌...",
        leftIcon: CommonImages.icArrowBack,
        rightIcon: CommonImages.icExit,
        onLeftIcon: () => Navigator.pop(context),
        onRightIcon: () async => showDialog(
          context: context,
          builder: (context) => OdyAlert(
            image: "assets/images/ic_sad_ody.svg",
            title: "어쩌구약속이름어쩌...",
            description: "약속을 정말 나가실 건가요?",
            confirmText: "나가기",
            onConfirm: () => Navigator.pop(context),
          ),
        ),
      );

  Widget _buildStatusList() => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            itemCount: userStatuses.length,
            itemBuilder: (context, index) => UserStatusItem(
              userStatus: userStatuses[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 18),
          ),
        ),
      );
}

class UserStatusItem extends StatelessWidget {
  const UserStatusItem({required this.userStatus, super.key});

  final UserStatus userStatus;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          _buildUserAvatar(),
          const SizedBox(width: 8),
          _buildUserInfo(),
        ],
      );

  Widget _buildUserAvatar() => ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(
          width: 44,
          height: 44,
          imageUrl: userStatus.imageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
        ),
      );

  Widget _buildUserInfo() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: userStatus.nickname,
                  style: PretendardFonts.bold18.copyWith(
                    color: CommonColors.gray_800,
                  ),
                ),
                TextSpan(
                  text: _getNotificationText(userStatus.userNotificationType),
                  style: PretendardFonts.medium18.copyWith(
                    color: CommonColors.gray_800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            userStatus.created,
            style: PretendardFonts.regular14.copyWith(
              color: CommonColors.gray_350,
            ),
          ),
        ],
      );

  String _getNotificationText(UserNotificationType notificationType) {
    switch (notificationType) {
      case UserNotificationType.entry:
        return "님이 들어왔어요.";
      case UserNotificationType.departureReminder:
        return "님이 출발할 시간이에요!";
      case UserNotificationType.departure:
        return "님이 출발했어요.";
      case UserNotificationType.nudge:
        return "님이 재촉 받았어요. \uD83D\uDC40";
      case UserNotificationType.memberDeletion:
        return "님이 오디를 떠났어요.";
      case UserNotificationType.memberExit:
        return "님이 나갔어요.";
    }
  }
}
