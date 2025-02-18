import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/screens/eta_board/model/eta_status.dart";
import "package:ody_flutter/screens/eta_board/model/mate_eta.dart";

class EtaBoardScreen extends StatefulWidget {
  const EtaBoardScreen({super.key});

  @override
  State<EtaBoardScreen> createState() => _EtaBoardScreenState();
}

class _EtaBoardScreenState extends State<EtaBoardScreen> {
  final List<MateEta> mateEtaList = [
    MateEta(name: "올리브", etaStatus: Arrived()),
    MateEta(name: "해음", etaStatus: LateWarning(13)),
    MateEta(name: "차람", etaStatus: Missing()),
    MateEta(name: "조조", etaStatus: ArrivalSoon(10)),
    MateEta(name: "제리", etaStatus: LateWarning(45)),
    MateEta(name: "카키", etaStatus: Missing()),
    MateEta(name: "콜리", etaStatus: ArrivalSoon(10)),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: CommonColors.cream,
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              const SizedBox(height: 32),
              _buildEtaList(),
            ],
          ),
        ),
      );

  Widget _buildTopBar() => OdyTopBar(
        title: "뭐라뭐라뭐라뭐라뭐라뭐라뭐라뭐라",
        leftIcon: CommonImages.icArrowBack,
        onLeftIcon: () => Navigator.pop(context),
        rightIcon: CommonImages.icShare,
        onRightIcon: () {
          // 유저 현황표 화면 스크린샷 공유 작업
        },
      );

  Widget _buildEtaList() => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: ListView.separated(
            itemBuilder: (context, index) => _buildEtaItem(mateEtaList[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 42),
            itemCount: mateEtaList.length,
          ),
        ),
      );

  Widget _buildEtaItem(MateEta mateEta) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              mateEta.name,
              style:
                  PretendardFonts.bold20.copyWith(color: CommonColors.gray_800),
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          _buildStatusBadge(mateEta.etaStatus),
          const SizedBox(
            width: 40,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  mateEta.etaStatus.statusMessage(),
                  style: PretendardFonts.regular16
                      .copyWith(color: CommonColors.black),
                ),
                if (mateEta.etaStatus is Missing)
                  Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: _buildTooltip()),
              ],
            ),
          ),
        ],
      );

  Widget _buildStatusBadge(EtaStatus etaStatus) => Container(
        width: 80,
        height: 32,
        decoration: BoxDecoration(
          color: etaStatus.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            etaStatus.badgeMessage,
            style:
                PretendardFonts.regular16.copyWith(color: CommonColors.white),
          ),
        ),
      );

  Widget _buildTooltip() => Tooltip(
        preferBelow: false,
        verticalOffset: 15,
        margin: const EdgeInsets.only(right: 40),
        triggerMode: TooltipTriggerMode.tap,
        decoration: const BoxDecoration(
          color: CommonColors.gray_400_70,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        message: "뭐라뭐라뭐라뭐라뭐라\n뭐라뭐라뭐라뭐라뭐라",
        textStyle:
            PretendardFonts.regular12.copyWith(color: CommonColors.white),
        child: SvgPicture.asset(CommonImages.icQuestionMark),
      );
}
