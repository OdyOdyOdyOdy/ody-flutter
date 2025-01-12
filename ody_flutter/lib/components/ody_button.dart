import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";

enum OdyButtonType {
  next,
  ody,
  confirm,
}

extension OdyButtonProperties on OdyButtonType {
  String get title {
    switch (this) {
      case OdyButtonType.next:
        return "다음";
      case OdyButtonType.ody:
        return "오디?";
      case OdyButtonType.confirm:
        return "확인";
    }
  }

  Size get size {
    switch (this) {
      case OdyButtonType.next:
        return const Size(360, 55);
      case OdyButtonType.ody:
        return const Size(86, 37);
      case OdyButtonType.confirm:
        return const Size(286, 45);
    }
  }

  double get radius {
    switch (this) {
      case OdyButtonType.next:
        return 0;
      case OdyButtonType.ody:
      case OdyButtonType.confirm:
        return 10;
    }
  }

  String get image {
    switch (this) {
      case OdyButtonType.ody:
        return "assets/images/ic_ody.svg";
      case OdyButtonType.next:
      case OdyButtonType.confirm:
        return "";
    }
  }
}

class OdyButton extends StatefulWidget {
  const OdyButton({
    required this.buttonType,
    required this.onPressed,
    required this.isEnabled,
    super.key,
  });

  final OdyButtonType buttonType;
  final VoidCallback onPressed;
  final ValueNotifier<bool> isEnabled;

  @override
  State<OdyButton> createState() => _OdyButtonState();
}

class _OdyButtonState extends State<OdyButton> {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: widget.isEnabled,
        builder: (_, isEnabled, __) => GestureDetector(
          onTap: isEnabled ? widget.onPressed : null,
          child: Container(
            decoration: BoxDecoration(
              color:
                  isEnabled ? CommonColors.purple_800 : CommonColors.gray_350,
              borderRadius: BorderRadius.circular(widget.buttonType.radius),
            ),
            width: widget.buttonType.size.width,
            height: widget.buttonType.size.height,
            child: (widget.buttonType.image.isNotEmpty)
                ? _imgTextButton()
                : _textButton(),
          ),
        ),
      );

  Widget _imgTextButton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          SvgPicture.asset(
            widget.buttonType.image,
            colorFilter: const ColorFilter.mode(
              CommonColors.white,
              BlendMode.srcIn,
            ),
          ),
          Text(
            widget.buttonType.title,
            style: const TextStyle(
              fontFamily: "PretendardBold",
              fontSize: 16,
              color: CommonColors.white,
            ),
          ),
        ],
      );

  Widget _textButton() => Center(
        child: Text(
          widget.buttonType.title,
          style: const TextStyle(
            fontFamily: "PretendardBold",
            fontSize: 16,
            color: CommonColors.white,
          ),
        ),
      );
}
