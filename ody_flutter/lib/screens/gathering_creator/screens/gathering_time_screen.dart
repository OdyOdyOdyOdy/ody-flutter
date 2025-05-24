import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/components/ody_time_picker.dart";
import "package:ody_flutter/screens/gathering_creator/gathering_creator_view_model.dart";

class GatheringTimeScreen extends StatelessWidget {
  const GatheringTimeScreen({
    required this.viewModel,
    super.key,
  });

  final GatheringCreatorViewModel viewModel;

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
          SizedBox(
            height: 120,
            child: OdyTimePicker(
              selectedHour: viewModel.hour,
              selectedMinute: viewModel.minute,
            ),
          ),
        ],
      );
}
