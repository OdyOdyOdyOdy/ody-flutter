import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/components/ody_button.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/components/ody_text_field.dart";
import "package:ody_flutter/screens/gathering_creator/gathering_creator_view_model.dart";

class GatheringTitleScreen extends StatelessWidget {
  const GatheringTitleScreen({required this.viewModel, super.key});

  final GatheringCreatorViewModel viewModel;

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, Widget? child) => Scaffold(
          backgroundColor: CommonColors.white,
          body: SafeArea(
            child: ColoredBox(
              color: CommonColors.white,
              child: Column(
                children: [
                  OdyHighlightText(
                    text: "무슨 약속인가요?",
                    highlightText: "약속",
                    textStyle: PretendardFonts.bold24.copyWith(
                      color: CommonColors.gray_800,
                    ),
                    highlightStyle: PretendardFonts.bold24.copyWith(
                      color: CommonColors.purple_800,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  OdyTextField(
                    textFieldType: OdyTextFieldType.textCounter,
                    placeHolder: "약속을 입력해주세요",
                    text: viewModel.text,
                  ),
                  const Spacer(),
                  OdyButton(
                    buttonType: OdyButtonType.next,
                    onPressed: () {},
                    isEnabled: viewModel.isConfirmEnabled,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
