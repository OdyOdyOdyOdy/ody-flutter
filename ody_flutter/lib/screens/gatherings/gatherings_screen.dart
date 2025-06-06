import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/network/base/base_service.dart";
import "package:ody_flutter/data/network/service/gathering_service_impl.dart";
import "package:ody_flutter/data/repository/gathering_repository_impl.dart";
import "package:ody_flutter/screens/gathering_creator/model/gathering.dart";
import "package:ody_flutter/screens/gatherings/gatherings_view_model.dart";

class GatheringsScreen extends StatefulWidget {
  const GatheringsScreen({super.key});

  @override
  State<GatheringsScreen> createState() => _GatheringsScreenState();
}

class _GatheringsScreenState extends State<GatheringsScreen> {
  late final GatheringsViewModel _viewModel;

  final ValueNotifier<bool> _isFloatingActionButtonPressed =
      ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _viewModel = GatheringsViewModel(
      GatheringRepositoryImpl(
        GatheringService(BaseService(), AuthTokenService()),
        AuthTokenService(),
      ),
    );
    unawaited(_viewModel.getGatherings());
  }

  // 임시 데이터 (API 연결 후 삭제)
  final List<Gathering> _gatherings = List.generate(
    3,
    (index) => Gathering(
      name: "김수한무거북이모임",
      date: "2024-09-10",
      time: "13:30",
      targetAddress: "서울 송파구 올림픽로 35다길",
      originAddress: "서울 강남구 테헤란로 411길",
      durationMinutes: "30",
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: CommonColors.cream,
        floatingActionButton: _buildFloatingActionButton(),
        body: SafeArea(
          child: Column(
            children: [
              OdyTopBar(
                title: "오디",
                rightIcon: CommonImages.icSetting,
                onRightIcon: () async =>
                    Navigator.pushNamed(context, Routes.settings),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ListView.separated(
                    itemCount: _gatherings.length,
                    itemBuilder: (context, index) =>
                        _buildGatheringItem(_gatherings[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildFloatingActionButton() => ValueListenableBuilder<bool>(
        valueListenable: _isFloatingActionButtonPressed,
        builder: (context, isPressed, child) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isPressed) _buildFloatingActionMenu(),
            const SizedBox(height: 18),
            FloatingActionButton(
              foregroundColor: CommonColors.white,
              backgroundColor: CommonColors.purple_300,
              onPressed: () =>
                  _isFloatingActionButtonPressed.value = !isPressed,
              shape: const CircleBorder(),
              child: isPressed
                  ? SvgPicture.asset(CommonImages.icCancel)
                  : SvgPicture.asset(CommonImages.icPlus),
            ),
          ],
        ),
      );

  Widget _buildFloatingActionMenu() => Column(
        children: [
          _buildFloatingActionButtonMenuItem(
            text: "약속 개설하기",
            onTap: () async => _navigateTo(Routes.gatheringCreation),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          _buildFloatingActionButtonMenuItem(
            text: "약속 참여하기",
            onTap: () async => _navigateTo(Routes.invitationCode),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
        ],
      );

  Widget _buildFloatingActionButtonMenuItem({
    required String text,
    required VoidCallback onTap,
    required BorderRadius borderRadius,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 173,
          height: 54,
          decoration: BoxDecoration(
            color: CommonColors.purple_300,
            borderRadius: borderRadius,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                text,
                style: PretendardFonts.medium18
                    .copyWith(color: CommonColors.white),
              ),
            ),
          ),
        ),
      );

  Widget _buildGatheringItem(Gathering gathering) => GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, Routes.gatheringDetail);
        },
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: CommonColors.gray_200,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22, top: 24, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gathering.name,
                      style: PretendardFonts.bold20
                          .copyWith(color: CommonColors.gray_800),
                    ),
                    const SizedBox(height: 7),
                    if (gathering.isExpanded)
                      _buildExpandedGatheringDetails(gathering)
                    else
                      Text(
                        gathering.time,
                        style: PretendardFonts.medium16
                            .copyWith(color: CommonColors.gray_800),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      "${gathering.durationMinutes}분 걸려요",
                      style: PretendardFonts.bold18
                          .copyWith(color: CommonColors.gray_800),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      "*대중교통 기준",
                      style: PretendardFonts.regular12
                          .copyWith(color: CommonColors.gray_400),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                top: 4,
                child: GestureDetector(
                  onTap: () => setState(
                    () => gathering.isExpanded = !gathering.isExpanded,
                  ),
                  child: SvgPicture.asset(
                    gathering.isExpanded
                        ? CommonImages.icArrowUp
                        : CommonImages.icArrowDown,
                  ),
                ),
              ),
              // 추후에 약속 시간 30분전 일때만 오디? 버튼 활성화 되게 변경 해야함
              Positioned(
                right: 22,
                bottom: 12,
                child: GestureDetector(
                  onTap: () async => _navigateTo(Routes.etaBoard),
                  child: Container(
                    width: 86,
                    height: 37,
                    decoration: const BoxDecoration(
                      color: CommonColors.purple_800,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(CommonImages.icOdy),
                        const SizedBox(width: 4),
                        Text(
                          "오디?",
                          style: PretendardFonts.bold16
                              .copyWith(color: CommonColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildExpandedGatheringDetails(Gathering gathering) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gathering.date,
            style:
                PretendardFonts.medium16.copyWith(color: CommonColors.gray_800),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: gathering.targetAddress,
                  style: PretendardFonts.regular14
                      .copyWith(color: CommonColors.purple_800),
                ),
                TextSpan(
                  text: "에서",
                  style: PretendardFonts.regular14
                      .copyWith(color: CommonColors.gray_600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: gathering.originAddress,
                  style: PretendardFonts.regular14
                      .copyWith(color: CommonColors.purple_800),
                ),
                TextSpan(
                  text: "까지",
                  style: PretendardFonts.regular14
                      .copyWith(color: CommonColors.gray_600),
                ),
              ],
            ),
          ),
        ],
      );

  Future<void> _navigateTo(String routeName) async {
    _isFloatingActionButtonPressed.value = false;
    await Navigator.pushNamed(context, routeName);
  }
}
