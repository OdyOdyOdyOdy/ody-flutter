import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_button.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/data/network/base/base_service.dart";
import "package:ody_flutter/data/network/service/gathering_service_impl.dart";
import "package:ody_flutter/data/repository/gathering_repository_impl.dart";
import "package:ody_flutter/screens/gathering_creator/gathering_creator_view_model.dart";
import "package:ody_flutter/screens/gathering_creator/screens/gathering_date_screen.dart";
import "package:ody_flutter/screens/gathering_creator/screens/gathering_location_screen.dart";
import "package:ody_flutter/screens/gathering_creator/screens/gathering_time_screen.dart";
import "package:ody_flutter/screens/gathering_creator/screens/gathering_title_screen.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class GatheringCreatorScreen extends StatelessWidget {
  GatheringCreatorScreen({super.key});

  // to do: 추후에 주입 필요
  final _viewModel = GatheringCreatorViewModel(
    GatheringRepositoryImpl(GatheringService(BaseService())),
  );

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
        listenable: _viewModel,
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
                    onLeftIcon: () async {
                      if (_viewModel.currentScreenType ==
                          GatheringCreatorScreenType.title) {
                        Navigator.pop(context);
                      } else {
                        await _viewModel.goToPreviousPage();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SmoothPageIndicator(
                    controller: _viewModel.pageController,
                    count: 4,
                    effect: const WormEffect(
                      dotColor: CommonColors.gray_300,
                      activeDotColor: CommonColors.purple_800,
                      dotWidth: 10,
                      dotHeight: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                  Expanded(
                    child: PageView(
                      controller: _viewModel.pageController,
                      physics: _viewModel.isGoingPrevious
                          ? const AlwaysScrollableScrollPhysics()
                          : _viewModel.isConfirmEnabled.value
                              ? const AlwaysScrollableScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                      children: [
                        GatheringTitleScreen(
                          viewModel: _viewModel,
                        ),
                        GatheringDateScreen(
                          viewModel: _viewModel,
                        ),
                        GatheringTimeScreen(
                          viewModel: _viewModel,
                        ),
                        GatheringLocationScreen(
                          viewModel: _viewModel,
                        ),
                      ],
                    ),
                  ),
                  OdyButton(
                    buttonType: OdyButtonType.next,
                    onPressed: () async {
                      if (_viewModel.currentScreenType ==
                          GatheringCreatorScreenType.location) {
                        await _viewModel.createGathering();
                        if (context.mounted) {
                          await Navigator.pushNamed(
                            context,
                            Routes.gatheringEnter,
                          );
                        }
                        return;
                      }

                      await _viewModel.goToNextPage();
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
      );
}
