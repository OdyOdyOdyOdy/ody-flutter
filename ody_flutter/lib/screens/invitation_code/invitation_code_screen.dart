import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_button.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/components/ody_text_field.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/screens/invitation_code/invitation_code_view_model.dart";

class InvitationCodeScreen extends StatelessWidget {
  InvitationCodeScreen({super.key});

  // to do: 추후에 주입 필요
  final InvitationCodeViewModel viewModel = InvitationCodeViewModel();

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, Widget? child) => Scaffold(
          backgroundColor: CommonColors.cream,
          body: SafeArea(
            child: ColoredBox(
              color: CommonColors.cream,
              child: Column(
                children: [
                  OdyTopBar(
                    title: "",
                    leftIcon: CommonImages.icArrowBack,
                    onLeftIcon: () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    height: 112,
                  ),
                  OdyHighlightText(
                    text: "초대 코드를 입력해주세요!",
                    highlightText: "초대 코드",
                    textStyle: PretendardFonts.bold24.copyWith(
                      color: CommonColors.gray_800,
                    ),
                    highlightStyle: PretendardFonts.bold24.copyWith(
                      color: CommonColors.purple_800,
                    ),
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                  OdyTextField(
                    textFieldType: OdyTextFieldType.clearButton,
                    placeHolder: "초대 코드",
                    text: viewModel.text,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  OdyButton(
                    buttonType: OdyButtonType.confirm,
                    onPressed: () async {
                      await viewModel.enterInvitationCode();
                      if (viewModel.isValidCode.value && context.mounted) {
                        await Navigator.pushNamed(
                          context,
                          Routes.gatheringEnter,
                        );
                      } else {
                        // to do: 초대 코드 유효하지 않을 때 토스트 메시지 띄우기
                      }
                    },
                    isEnabled: viewModel.isConfirmEnabled,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
