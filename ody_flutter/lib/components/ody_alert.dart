import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";

class OdyAlert extends StatelessWidget {
  final VoidCallback onConfirm;

  const OdyAlert({
    required this.image,
    required this.title,
    required this.description,
    required this.confirmText,
    required this.onConfirm,
    super.key,
  });

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
      style: const TextStyle(
        color: CommonColors.purple_800,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );

  Widget _description() => Text(
      description,
      style: const TextStyle(
        color: CommonColors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );

  Widget _buttons(final BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Text(
            "취소",
            style: TextStyle(
              color: CommonColors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Container(
          width: 1,
          height: 49,
          color: CommonColors.gray_350,
        ),
        GestureDetector(
          onTap: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text(
            confirmText,
            style: const TextStyle(
              color: CommonColors.red_500,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
}