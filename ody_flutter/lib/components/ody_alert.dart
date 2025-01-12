import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendart_fonts.dart";

class OdyAlert extends StatelessWidget {
  const OdyAlert({
    required this.image,
    required this.title,
    required this.description,
    required this.confirmText,
    required this.onConfirm,
    super.key,
  });

  final VoidCallback onConfirm;

  final String image;
  final String title;
  final String description;
  final String confirmText;

  @override
  Widget build(final BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: CommonColors.cream,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: _odyDialogContent(context),
        ),
      );

  Widget _odyDialogContent(final BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          SvgPicture.asset(image),
          const SizedBox(height: 35),
          _title(),
          const SizedBox(height: 8),
          _description(),
          const SizedBox(height: 40),
          const Divider(height: 1, color: CommonColors.gray_350),
          _buttons(context),
        ],
      );

  Widget _title() => Text(
        title,
        style: PretendardFonts.bold24.copyWith(
          color: CommonColors.purple_800,
        ),
      );

  Widget _description() => Text(
        description,
        style: PretendardFonts.medium16.copyWith(
          color: CommonColors.black,
        ),
      );

  Widget _buttons(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                "취소",
                style: PretendardFonts.medium18.copyWith(
                  color: CommonColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 49,
            color: CommonColors.gray_350,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onConfirm();
                Navigator.pop(context);
              },
              child: Text(
                confirmText,
                style: PretendardFonts.medium18.copyWith(
                  color: CommonColors.red_500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
}
