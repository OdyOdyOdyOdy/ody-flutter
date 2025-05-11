import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";

class GatheringEnterCompleteScreen extends StatelessWidget {
  const GatheringEnterCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
                  text: "우테코 회식 모임\n약속에 참여했어요!",
                  highlightText: "우테코 회식 모임",
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
      );
}
