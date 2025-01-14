import "package:flutter/cupertino.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";

class OdyTopBar extends StatelessWidget {
  const OdyTopBar({
    required this.title,
    this.leftIcon = "",
    this.subTitle = "",
    this.rightIcon = "",
    this.onLeftIcon,
    this.onRightIcon,
    super.key,
  });

  final VoidCallback? onLeftIcon;
  final VoidCallback? onRightIcon;

  final String title;
  final String leftIcon;
  final String subTitle;
  final String rightIcon;

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: CommonColors.cream,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: onLeftIcon ?? () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(leftIcon),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: PretendardFonts.bold22.copyWith(
                      color: CommonColors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    subTitle,
                    style: PretendardFonts.bold18.copyWith(
                      color: CommonColors.gray_500,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onRightIcon,
                    child: SvgPicture.asset(rightIcon),
                  ),
                  const SizedBox(width: 14),
                ],
              ),
            ],
          ),
        ),
      );
}
