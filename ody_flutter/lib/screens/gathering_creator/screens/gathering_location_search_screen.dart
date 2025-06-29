import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_text_field.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/network/base/base_service.dart";
import "package:ody_flutter/data/network/service/location_service.dart";
import "package:ody_flutter/data/repository/location_repository_impl.dart";
import "package:ody_flutter/domain/model/location.dart";
import "package:ody_flutter/screens/gathering_creator/screens/gathering_location_view_model.dart";

class GatheringLocationSearchScreen extends StatelessWidget {
  GatheringLocationSearchScreen({super.key});

  final GatheringLocationViewModel _viewModel = GatheringLocationViewModel(
    LocationRepositoryImpl(LocationService(BaseService(AuthTokenService()))),
  );

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: _viewModel,
        builder: (BuildContext context, Widget? child) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: CommonColors.cream,
            body: SafeArea(
              child: Column(
                children: [
                  OdyTopBar(
                    title: "장소 찾기",
                    leftIcon: CommonImages.icArrowBack,
                    onLeftIcon: () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  OdyTextField(
                    textFieldType: OdyTextFieldType.clearButton,
                    placeHolder: "주소나 상호명을 검색해 보세요",
                    text: _viewModel.text,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    color: CommonColors.gray_300,
                    height: 3,
                  ),
                  Expanded(
                    child: _viewModel.locationList.isEmpty
                        ? _emptyView()
                        : _locationListView(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _emptyView() => Center(
        child: Text(
          "검색 결과가\n 존재하지 않아요.",
          style: PretendardFonts.medium18.copyWith(
            color: CommonColors.gray_350,
          ),
          textAlign: TextAlign.center,
        ),
      );

  Widget _locationListView(BuildContext context) => ListView.separated(
        itemCount: _viewModel.locationList.length,
        itemBuilder: (context, index) => _locationView(
          () => Navigator.pop(context, _viewModel.locationList[index]),
          _viewModel.locationList[index],
        ),
        separatorBuilder: (BuildContext context, int index) => Container(
          color: CommonColors.gray_350,
          height: 1,
        ),
      );

  Widget _locationView(Function() onTap, LocationModel location) =>
      GestureDetector(
        onTap: () => onTap(),
        child: SizedBox(
          height: 84,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 26,
                child: SvgPicture.asset(CommonImages.icLocationOn),
              ),
              Positioned(
                top: 22,
                left: 54,
                child: Text(
                  location.name ?? "",
                  style: PretendardFonts.bold16.copyWith(
                    color: CommonColors.purple_800,
                  ),
                ),
              ),
              Positioned(
                top: 47,
                left: 54,
                child: Text(
                  location.address ?? "",
                  style: PretendardFonts.regular14.copyWith(
                    color: CommonColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
