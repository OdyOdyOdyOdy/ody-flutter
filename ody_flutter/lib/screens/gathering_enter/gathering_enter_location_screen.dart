import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
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
import "package:ody_flutter/screens/base/base_screen.dart";
import "package:ody_flutter/screens/gathering_enter/gathering_enter_view_model.dart";
import "package:ody_flutter/screens/gathering_enter/model/gathering_enter_argument.dart";

class GatheringEnterScreen extends StatefulWidget {
  const GatheringEnterScreen({
    super.key,
  });

  @override
  State<GatheringEnterScreen> createState() => _GatheringEnterScreenState();
}

class _GatheringEnterScreenState extends State<GatheringEnterScreen> {
  final GatheringEnterViewModel _viewModel = getIt<GatheringEnterViewModel>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null && arguments is String) {
        await _viewModel.setInvitationCode(arguments);
      }
    });
  }

  @override
  Widget build(final BuildContext context) => BaseScreen(
        viewModel: _viewModel,
        builder: (context) => ValueListenableBuilder<bool>(
          valueListenable: _viewModel.isCompleted,
          builder: (context, isCompleted, child) {
            if (isCompleted && mounted) {
              debugPrint("isCompleted: $isCompleted");
              WidgetsBinding.instance.addPostFrameCallback((_) {
                unawaited(
                  Navigator.pushNamed(
                    context,
                    Routes.gatheringEnterComplete,
                    arguments: GatheringEnterArgument(
                      title: _viewModel.title,
                      gatheringId: _viewModel.gatheringId,
                    ),
                  ),
                );
                _viewModel.isCompleted.value = false;
              });
            }
            return child!;
          },
          child: ListenableBuilder(
            listenable: _viewModel,
            builder: (context, _) => Scaffold(
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
                                text: _viewModel.locationText,
                              ),
                            ),
                            Positioned(
                              right: 30,
                              bottom: 1,
                              child: IconButton(
                                iconSize: 30,
                                constraints: const BoxConstraints(
                                  minWidth: 50,
                                  minHeight: 50,
                                ),
                                onPressed: () async {
                                  await HapticFeedback.lightImpact();
                                  await _viewModel.fetchCurrentLocation();
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
                            _viewModel.setLocation(result as LocationModel);
                          }
                        },
                      ),
                      const Spacer(),
                      OdyButton(
                        buttonType: OdyButtonType.next,
                        onPressed: () async {
                          await _viewModel.enterGathering();
                        },
                        isEnabled: _viewModel.isConfirmEnabled,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
