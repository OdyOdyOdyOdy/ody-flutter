import "dart:async";

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get_it/get_it.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_alert.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/domain/model/noti_log.dart";
import "package:ody_flutter/screens/status_board/model/user_notification_type.dart";
import "package:ody_flutter/screens/status_board/model/user_status.dart";
import "package:ody_flutter/screens/status_board/status_board_view_model.dart";
import "package:provider/provider.dart";

class StatusBoardScreen extends StatefulWidget {
  const StatusBoardScreen({
    required this.meetingId,
    required this.title,
    super.key,
  });

  final int meetingId;
  final String title;

  @override
  State<StatusBoardScreen> createState() => _StatusBoardScreenState();
}

class _StatusBoardScreenState extends State<StatusBoardScreen> {
  late final StatusBoardViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = GetIt.instance<StatusBoardViewModel>();
    unawaited(viewModel.getStatusBoard(widget.meetingId));
    unawaited(viewModel.getDetailGathering(widget.meetingId));
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => viewModel,
        child: Scaffold(
          floatingActionButton: _buildFloatingActionButton(context),
          backgroundColor: CommonColors.cream,
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(context),
                const SizedBox(height: 24),
                Consumer<StatusBoardViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return _buildStatusList(viewModel.notiLogs);
                  },
                ),
              ],
            ),
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
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  Widget _buildTopBar(BuildContext context) => OdyTopBar(
        title: widget.title,
        leftIcon: CommonImages.icArrowBack,
        rightIcon: CommonImages.icExit,
        onLeftIcon: () => Navigator.pop(context),
        onRightIcon: () async => showDialog(
          context: context,
          builder: (context) => OdyAlert(
            image: CommonImages.icSadOdy,
            title: widget.title,
            description: "약속을 정말 나가실 건가요?",
            confirmText: "나가기",
            onConfirm: () => Navigator.pop(context),
          ),
        ),
      );

  Widget _buildStatusList(List<NotiLog> notiLogs) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            itemCount: notiLogs.length,
            itemBuilder: (context, index) {
              final userStatus = _mapNotiLogToUserStatus(notiLogs[index]);
              return UserStatusItem(userStatus: userStatus);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 18),
          ),
        ),
      );

  UserStatus _mapNotiLogToUserStatus(NotiLog notiLog) => UserStatus(
      nickname: notiLog.nickname,
      created: notiLog.createdAt,
      imageUrl: notiLog.imageUrl,
      userNotificationType: _mapToUserNotificationType(notiLog.type),
    );

  UserNotificationType _mapToUserNotificationType(String type) {
    switch (type) {
      case "ENTER":
        return UserNotificationType.entry;
      case "DEPARTURE":
        return UserNotificationType.departure;
      case "DELETION":
        return UserNotificationType.memberDeletion;
      default:
        return UserNotificationType.entry;
    }
  }
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
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
