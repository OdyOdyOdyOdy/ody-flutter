import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/components/ody_button.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/components/ody_text_field.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/screens/gathering_creator/gathering_creator_view_model.dart";
import "package:ody_flutter/screens/gathering_creator/model/location.dart";

class GatheringLocationScreen extends StatelessWidget {
  const GatheringLocationScreen({required this.viewModel, super.key});

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
                    text: "오디서 만나시나요?",
                    highlightText: "오디",
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
                  GestureDetector(
                    child: AbsorbPointer(
                      child: OdyTextField(
                        textFieldType: OdyTextFieldType.clearButton,
                        placeHolder: "주소를 찾아보세요",
                        text: viewModel.locationText,
                      ),
                    ),
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        Routes.gatheringLocationSearch,
                        arguments: Location(),
                      );

                      if (result != null) {
                        viewModel.locationText.value =
                            (result as Location).address ?? "";
                        viewModel.isConfirmEnabled.value = true;
                      }
                    },
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
