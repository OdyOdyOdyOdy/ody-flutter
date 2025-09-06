import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_button.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/components/ody_text_field.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/di/di.dart";
import "package:ody_flutter/domain/model/location.dart";
import "package:ody_flutter/screens/gathering_enter/gathering_enter_view_model.dart";

class GatheringEnterScreen extends StatefulWidget {
  const GatheringEnterScreen({
    super.key,
  });

  @override
  State<GatheringEnterScreen> createState() => _GatheringEnterScreenState();
}

class _GatheringEnterScreenState extends State<GatheringEnterScreen> {
  final GatheringEnterViewModel viewModel = getIt<GatheringEnterViewModel>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null && arguments is String) {
        await viewModel.setInvitationCode(arguments);
      }
    });
  }

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
        listenable: Listenable.merge([
          viewModel.locationText,
          viewModel.isCompleted,
        ]),
        builder: (BuildContext context, Widget? child) {
          if (viewModel.isCompleted.value && mounted) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                unawaited(
                  Navigator.pushNamed(
                    context,
                    Routes.gatheringEnterComplete,
                  ),
                );
              },
            );
          }

          return Scaffold(
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
                      text: "오디서 출발하시나요?",
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
                      child: Stack(
                        children: [
                          AbsorbPointer(
                            child: OdyTextField(
                              textFieldType: OdyTextFieldType.none,
                              placeHolder: "주소를 찾아보세요",
                              text: viewModel.locationText,
                            ),
                          ),
                          Positioned(
                            right: 30,
                            bottom: 1,
                            child: IconButton(
                              iconSize: 30,
                              onPressed: () async {
                                await viewModel.fetchCurrentLocation();
                              },
                              icon: SvgPicture.asset(
                                CommonImages.icCurrentLocation,
                              ),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          Routes.gatheringLocationSearch,
                          arguments: LocationModel,
                        );

                        if (result != null) {
                          viewModel.setLocation(result as LocationModel);
                        }
                      },
                    ),
                    const Spacer(),
                    OdyButton(
                      buttonType: OdyButtonType.next,
                      onPressed: () async {
                        await viewModel.enterGathering();
                      },
                      isEnabled: viewModel.isConfirmEnabled,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
