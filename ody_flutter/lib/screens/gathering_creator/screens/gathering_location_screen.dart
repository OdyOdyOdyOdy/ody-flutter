import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/components/ody_text_field.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/domain/model/location.dart";
import "package:ody_flutter/screens/gathering_creator/gathering_creator_view_model.dart";

class GatheringLocationScreen extends StatelessWidget {
  const GatheringLocationScreen({required this.viewModel, super.key});

  final GatheringCreatorViewModel viewModel;

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: CommonColors.cream,
        body: SafeArea(
          child: ColoredBox(
            color: CommonColors.cream,
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
                      textFieldType: OdyTextFieldType.none,
                      placeHolder: "주소를 찾아보세요",
                      text: viewModel.locationText,
                    ),
                  ),
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      Routes.gatheringLocationSearch,
                      arguments: LocationModel,
                    );

                    if (result != null) {
                      viewModel.locationText.value =
                          (result as LocationModel).address ??
                              result.name ??
                              "";
                      viewModel.location = result;
                      viewModel.isConfirmEnabled.value = true;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
