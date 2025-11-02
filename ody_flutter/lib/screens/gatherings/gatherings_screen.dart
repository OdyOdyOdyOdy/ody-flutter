import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/di/di.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/screens/base/base_screen.dart";
import "package:ody_flutter/screens/eta_board/model/eta_board_argument.dart";
import "package:ody_flutter/screens/gatherings/gatherings_view_model.dart";

class GatheringsScreen extends StatefulWidget {
  const GatheringsScreen({super.key});

  @override
  State<GatheringsScreen> createState() => _GatheringsScreenState();
}

class _GatheringsScreenState extends State<GatheringsScreen> with RouteAware {
  late final GatheringsViewModel _viewModel;

  final ValueNotifier<bool> _isFloatingActionButtonPressed =
      ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<GatheringsViewModel>();
    unawaited(_viewModel.getGatherings());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    unawaited(_viewModel.getGatherings());
  }

  @override
  Widget build(BuildContext context) => BaseScreen(
        viewModel: _viewModel,
        builder: (context) => PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: CommonColors.cream,
            floatingActionButton: _buildFloatingActionButton(),
            body: SafeArea(
              child: Stack(
                children: [
                  if (!_viewModel.isLoading && _viewModel.gatherings.isEmpty)
                    _buildEmptyGathering()
                  else if (!_viewModel.isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: ListView.separated(
                                itemCount: _viewModel.gatherings.length,
                                itemBuilder: (context, index) =>
                                    _buildGatheringItem(
                                  _viewModel.gatherings[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  OdyTopBar(
                    title: "오디",
                    rightIcon: CommonImages.icSetting,
                    onRightIcon: () async =>
                        Navigator.pushNamed(context, Routes.settings),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isFloatingActionButtonPressed,
                    builder: (context, isPressed, child) {
                      if (!isPressed) {
                        return const SizedBox.shrink();
                      }
                      return GestureDetector(
                        onTap: () {
                          _isFloatingActionButtonPressed.value = false;
                        },
                        child: Container(
                          color: Colors.transparent,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildEmptyGathering() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(CommonImages.icSadOdy),
            const SizedBox(height: 39),
            Text(
              "아직 약속이 없어요.\n약속을 만들어 주세요!",
              style: PretendardFonts.bold24.copyWith(color: CommonColors.black),
              textAlign: TextAlign.center,
            ),
          ],
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
              onPressed: () async {
                await HapticFeedback.lightImpact();
                _isFloatingActionButtonPressed.value = !isPressed;
              },
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
          await Navigator.pushNamed(
            context,
            Routes.gatheringDetail,
            arguments: gathering.id,
          );
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
                        gathering.dateTimeMessage(),
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
                  onTap: () async {
                    await HapticFeedback.lightImpact();
                    setState(
                      () => gathering.isExpanded = !gathering.isExpanded,
                    );
                  },
                  child: SvgPicture.asset(
                    gathering.isExpanded
                        ? CommonImages.icArrowUp
                        : CommonImages.icArrowDown,
                  ),
                ),
              ),
              Positioned(
                right: 22,
                bottom: 12,
                child: GestureDetector(
                  onTap: gathering.isAccessible
                      ? () async {
                          await HapticFeedback.lightImpact();
                          _isFloatingActionButtonPressed.value = false;
                          if (mounted) {
                            await Navigator.pushNamed(
                              context,
                              Routes.etaBoard,
                              arguments: EtaBoardArgument(
                                title: gathering.name,
                                gatheringId: gathering.id,
                          time: gathering.time,
                              ),
                            );
                          }
                        }
                      : () {},
                  child: Container(
                    width: 86,
                    height: 37,
                    decoration: BoxDecoration(
                      color: gathering.isAccessible
                          ? CommonColors.purple_800
                          : CommonColors.cream,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: gathering.isAccessible
                            ? CommonColors.purple_800
                            : CommonColors.gray_350,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          CommonImages.icOdy,
                          colorFilter: ColorFilter.mode(
                            gathering.isAccessible
                                ? CommonColors.white
                                : CommonColors.gray_350,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "오디?",
                          style: PretendardFonts.bold16.copyWith(
                            color: gathering.isAccessible
                                ? CommonColors.white
                                : CommonColors.gray_350,
                          ),
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
            gathering.formattedDate,
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
