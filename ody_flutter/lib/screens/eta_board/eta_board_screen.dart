import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/di/di.dart";
import "package:ody_flutter/domain/model/eta_status.dart";
import "package:ody_flutter/domain/model/user_eta.dart";
import "package:ody_flutter/screens/base/base_screen.dart";
import "package:ody_flutter/screens/eta_board/eta_board_view_model.dart";
import "package:screenshot/screenshot.dart";

class EtaBoardScreen extends StatefulWidget {
  const EtaBoardScreen({
    required this.title,
    required this.gatheringId,
    required this.time,
    super.key,
  });

  final String title;
  final int gatheringId;
  final String time;

  @override
  State<EtaBoardScreen> createState() => _EtaBoardScreenState();
}

class _EtaBoardScreenState extends State<EtaBoardScreen> {
  late final EtaBoardViewModel _viewModel;
  late final ScreenshotController _screenshotController;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<EtaBoardViewModel>();
    _screenshotController = ScreenshotController();
    unawaited(_viewModel.patchEtaBoard(widget.gatheringId));
  }

  @override
  void dispose() {
    debugPrint("EtaBoardScreen dispose");
    _viewModel.stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BaseScreen(
        viewModel: _viewModel,
        builder: (context) => Scaffold(
          backgroundColor: CommonColors.cream,
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Screenshot(
                      controller: _screenshotController,
                      child: ColoredBox(
                        color: CommonColors.cream,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _buildEtaItem(
                            _viewModel.userEta?.mateEtas[index],
                          ),
                          itemCount: _viewModel.userEta?.mateEtas.length ?? 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildTopBar() => OdyTopBar(
        title: widget.title,
        leftIcon: CommonImages.icArrowBack,
        onLeftIcon: () => Navigator.pop(context),
        rightIcon: CommonImages.icShare,
        onRightIcon: () => unawaited(
          _viewModel.shareScreenshot(_screenshotController),
        ),
      );

  Widget _buildEtaItem(MateEta? mateEta) => Padding(
        padding: const EdgeInsets.fromLTRB(36, 21, 36, 21),
        child: Row(
          children: [
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                mateEta?.name ?? "",
                style: PretendardFonts.bold20
                    .copyWith(color: CommonColors.gray_800),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: _buildStatusBadge(mateEta),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      textAlign: TextAlign.center,
                      mateEta?.etaStatus.statusMessage() ?? "",
                      style: PretendardFonts.medium16
                          .copyWith(color: CommonColors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (mateEta?.etaStatus is Missing)
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: _buildTooltip(mateEta?.mateId),
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildStatusBadge(MateEta? mateEta) => GestureDetector(
        onTap: () {
          if (mateEta == null) {
            return;
          }
          unawaited(
            _viewModel.performNudge(
              nudgedMateId: mateEta.mateId,
              nudgedMateName: mateEta.name,
            ),
          );
        },
        child: Container(
          width: 80,
          height: 34,
          decoration: BoxDecoration(
            color: mateEta?.etaStatus.color,
            borderRadius: BorderRadius.circular(17),
          ),
          child: Center(
            child: Text(
              mateEta?.etaStatus.badgeMessage ?? "",
              style: PretendardFonts.medium16.copyWith(
                color: CommonColors.white,
              ),
            ),
          ),
        ),
      );

  Widget _buildTooltip(int? mateId) => Tooltip(
        preferBelow: false,
        verticalOffset: 15,
        margin: const EdgeInsets.only(right: 40),
        triggerMode: TooltipTriggerMode.tap,
        decoration: const BoxDecoration(
          color: CommonColors.gray_400_70,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        message: (_viewModel.userEta?.requesterMateId == mateId)
            ? "위치 권한을 켜서 오디인지 공유해 보세요."
            : "친구의 위치 권한이 꺼져있어요.",
        textStyle:
            PretendardFonts.regular12.copyWith(color: CommonColors.white),
        child: SvgPicture.asset(CommonImages.icQuestionMark),
      );
}
