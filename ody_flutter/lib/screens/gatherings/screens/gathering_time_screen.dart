import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/components/ody_button.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/components/ody_time_picker.dart";

class GatheringTimeScreen extends StatelessWidget {
  const GatheringTimeScreen({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          OdyHighlightText(
            text: "몇시에 만나시나요?",
            highlightText: "몇시에",
            textStyle: PretendardFonts.bold24.copyWith(
              color: CommonColors.gray_800,
            ),
            highlightStyle: PretendardFonts.bold24.copyWith(
              color: CommonColors.purple_800,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          const SizedBox(
            height: 120,
            child: OdyTimePicker(),
          ),
          const Spacer(),
          OdyButton(
            buttonType: OdyButtonType.next,
            onPressed: () {},
            isEnabled: ValueNotifier(true),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
