import "dart:async";

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:intl/intl.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_alert.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/network/base/base_service.dart";
import "package:ody_flutter/data/network/service/gathering_service_impl.dart";
import "package:ody_flutter/data/repository/gathering_repository_impl.dart";
import "package:ody_flutter/domain/model/gathering_detail.dart";
import "package:ody_flutter/screens/gathering_detail/gathering_detail_view_model.dart";

class GatheringDetailScreen extends StatefulWidget {
  const GatheringDetailScreen({
    required this.gatheringId,
    super.key,
  });

  final int gatheringId;

  @override
  State<GatheringDetailScreen> createState() => _GatheringDetailScreenState();
}

class _GatheringDetailScreenState extends State<GatheringDetailScreen> {
  late final GatheringDetailViewModel _viewModel;

  final ValueNotifier<bool> _isFloatingActionButtonPressed =
  ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _viewModel = GatheringDetailViewModel(
      GatheringRepositoryImpl(
        GatheringService(BaseService(AuthTokenService()), AuthTokenService()),
        AuthTokenService(),
      ),
    );
    _viewModel.addListener(_onViewModelChanged);
    unawaited(_viewModel.getDetailGathering(widget.gatheringId));
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  String _formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    if (dateTime.minute == 0) {
      return DateFormat("yyyy년 MM월 dd일 a h시", "ko_KR").format(dateTime);
    } else {
      return DateFormat("yyyy년 MM월 dd일 a h시 mm분", "ko_KR").format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: CommonColors.cream,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              _buildMatesSection(),
              const SizedBox(height: 44),
              _buildDetailSection(),
            ],
          ),
        ),
      );

  Widget _buildTopBar(BuildContext context) =>
      OdyTopBar(
        title: _viewModel.detailGathering?.name ?? "",
        leftIcon: CommonImages.icArrowBack,
        rightIcon: CommonImages.icExit,
        onLeftIcon: () => Navigator.pop(context),
        onRightIcon: () async =>
            showDialog(
              context: context,
              builder: (context) =>
                  OdyAlert(
                    image: CommonImages.icSadOdy,
                    title: _viewModel.detailGathering?.name ?? "",
                    description: "약속을 정말 나가실 건가요?",
                    confirmText: "나가기",
                    onConfirm: () => Navigator.pop(context),
                  ),
            ),
      );

  Widget _buildMatesSection() =>
      SizedBox(
        height: 123,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
            color: CommonColors.cream,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, top: 14, right: 36),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _viewModel.detailGathering?.mates?.length ?? 0 + 1,
              itemBuilder: (context, index) {
                if (index == _viewModel.detailGathering?.mates?.length) {
                  return _buildInviteFriendSection();
                } else {
                  return _buildMateSection(
                    _viewModel.detailGathering!.mates![index],
                  );
                }
              },
              separatorBuilder: (context, index) =>
              index == _viewModel.detailGathering!.mates!.length - 1
                  ? const SizedBox(width: 36)
                  : const SizedBox(width: 8),
            ),
          ),
        ),
      );

  Widget _buildInviteFriendSection() =>
      Column(
        children: [
          Text(
            "친구를 초대해 보세요!",
            style: PretendardFonts.regular14
                .copyWith(color: CommonColors.gray_800),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              // 초대 코드 복사하기
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: CommonColors.gray_300),
              backgroundColor: CommonColors.gray_300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              "초대 코드 복사하기",
              style: PretendardFonts.regular14
                  .copyWith(color: CommonColors.gray_500),
            ),
          ),
        ],
      );

  Widget _buildMateSection(Mates mate) =>
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              width: 58,
              height: 58,
              imageUrl: mate.imageUrl ?? "",
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            mate.nickname ?? "",
            style: PretendardFonts.regular14
                .copyWith(color: CommonColors.gray_800),
          ),
        ],
      );

  Widget _buildDetailSection() =>
      Padding(
        padding: const EdgeInsets.only(left: 28, right: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem(
              "약속 시간",
              _viewModel.detailGathering?.date != null &&
                  _viewModel.detailGathering?.time != null
                  ? _formatDateTime(
                "${_viewModel.detailGathering!.date} ${_viewModel
                    .detailGathering!.time }",
              )
                  : "",
            ),
            const SizedBox(height: 28),
            _buildDetailItem(
              "약속 장소",
              _viewModel.detailGathering?.targetAddress ?? "",
            ),
            const SizedBox(height: 28),
            _buildDetailItem(
              "출발 장소",
              _viewModel.detailGathering?.originAddress ?? "",
            ),
            const SizedBox(height: 28),
            _buildDepartureInfoSection(),
          ],
        ),
      );

  Widget _buildDetailItem(String title, String content) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
            PretendardFonts.bold18.copyWith(color: CommonColors.purple_800),
          ),
          Text(
            content,
            style: PretendardFonts.regular16
                .copyWith(color: CommonColors.gray_800),
          ),
        ],
      );

  Widget _buildDepartureInfoSection() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "늦지 않으려면",
                style: PretendardFonts.bold18
                    .copyWith(color: CommonColors.purple_800),
              ),
              const SizedBox(width: 10),
              Tooltip(
                preferBelow: false,
                verticalOffset: 5,
                margin: const EdgeInsets.only(left: 140),
                triggerMode: TooltipTriggerMode.tap,
                decoration: const BoxDecoration(
                  color: CommonColors.gray_400_70,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                message: "뭐라뭐라뭐라뭐라뭐라\n뭐라뭐라뭐라뭐라뭐라",
                textStyle: PretendardFonts.regular12
                    .copyWith(color: CommonColors.white),
                child: SvgPicture.asset(CommonImages.icInformation),
              ),
            ],
          ),
          Text(
            "오후 ${_viewModel.detailGathering?.departureTime ?? ""}분에 나가야 해요."
                "\n출발 장소부터 약속 장소까지 ${_viewModel.detailGathering?.routeTime ??
                ""}분 걸려요.",
            style: PretendardFonts.regular16
                .copyWith(color: CommonColors.gray_800),
          ),
        ],
      );

  Widget _buildFloatingActionButton() =>
      ValueListenableBuilder<bool>(
        valueListenable: _isFloatingActionButtonPressed,
        builder: (context, isPressed, child) =>
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isPressed) _buildOdyButton(),
                const SizedBox(width: 18),
                FloatingActionButton(
                  foregroundColor: CommonColors.white,
                  backgroundColor: CommonColors.purple_800,
                  onPressed: () =>
                  _isFloatingActionButtonPressed.value = !isPressed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: isPressed
                      ? SvgPicture.asset(CommonImages.icBigCancel)
                      : SvgPicture.asset(CommonImages.icOdy),
                ),
                const SizedBox(width: 18),
                if (isPressed) _buildLogButton(),
              ],
            ),
      );

  Widget _buildOdyButton() =>
      OutlinedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, Routes.etaBoard);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: CommonColors.purple_800),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              CommonImages.icOdy,
              colorFilter: const ColorFilter.mode(
                CommonColors.purple_800,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "오디?",
              style: PretendardFonts.bold16
                  .copyWith(color: CommonColors.purple_800),
            ),
          ],
        ),
      );

  Widget _buildLogButton() =>
      OutlinedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, Routes.statusBoard);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: CommonColors.purple_800),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          "약속 로그",
          style:
          PretendardFonts.bold16.copyWith(color: CommonColors.purple_800),
        ),
      );
}
