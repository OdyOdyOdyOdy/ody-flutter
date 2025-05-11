import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_text_field.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/screens/gathering_creator/model/location.dart";

class GatheringLocationSearchScreen extends StatelessWidget {
  GatheringLocationSearchScreen({super.key});

  final ValueNotifier<String> text = ValueNotifier("");

  final List<Location> locations = [
    Location(
      title: "사당역 2호선",
      address: "서울 동작구 남부순환로 208",
    ),
    Location(
      title: "사당역 4호선",
      address: "서울 동작구 동작대로 3 사당역",
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
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
                text: text,
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                color: CommonColors.gray_300,
                height: 3,
              ),
              Expanded(
                child: _locationListView(
                  context,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _locationListView(BuildContext context) => ListView.separated(
        itemCount: locations.length,
        itemBuilder: (context, index) => _locationView(
          () => Navigator.pop(context, locations[index]),
          locations[index],
        ),
        separatorBuilder: (BuildContext context, int index) => Container(
          color: CommonColors.gray_350,
          height: 1,
        ),
      );

  Widget _locationView(Function() onTap, Location location) => GestureDetector(
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
                  location.title ?? "",
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
