import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/config/routes.dart";

class GatheringEnterCompleteScreen extends StatefulWidget {
  const GatheringEnterCompleteScreen({
    required this.title,
    required this.gatheringId,
    super.key,
  });

  final String title;
  final int gatheringId;

  @override
  State<GatheringEnterCompleteScreen> createState() =>
      _GatheringEnterCompleteScreenState();
}

class _GatheringEnterCompleteScreenState
    extends State<GatheringEnterCompleteScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1300), () async {
      if (!mounted) {
        return;
      }

      await Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.gatheringDetail,
        ModalRoute.withName(Routes.gatherings),
        arguments: widget.gatheringId,
      );
    });
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: CommonColors.cream,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    CommonImages.icTogetherOdy,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  OdyHighlightText(
                    text: "${widget.title}\n약속에 참여했어요!",
                    highlightText: widget.title,
                    textStyle: PretendardFonts.bold24.copyWith(
                      color: CommonColors.black,
                    ),
                    highlightStyle: PretendardFonts.bold24.copyWith(
                      color: CommonColors.purple_800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
