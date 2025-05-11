import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";

enum OdyTextFieldType {
  none,
  clearButton,
  textCounter,
}

class OdyTextField extends StatefulWidget {
  const OdyTextField({
    required this.textFieldType,
    required this.placeHolder,
    required this.text,
    super.key,
  });

  final OdyTextFieldType textFieldType;
  final String placeHolder;
  final ValueNotifier<String> text;

  @override
  State<OdyTextField> createState() => _OdyTextFieldState();
}

class _OdyTextFieldState extends State<OdyTextField> {
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ValueListenableBuilder(
          valueListenable: widget.text,
          builder: (
            final BuildContext context,
            final String value,
            final Widget? child,
          ) {
            _textFieldController.text = widget.text.value;
            return SizedBox(
              height: 42,
              child: TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  hintText: widget.placeHolder,
                  hintStyle: PretendardFonts.medium20.copyWith(
                    color: CommonColors.gray_350,
                  ),
                  enabledBorder: _inputBorder(),
                  focusedBorder: _inputBorder(),
                  contentPadding: EdgeInsets.zero,
                  suffixIcon: _suffixIcon(),
                ),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15),
                ],
                onChanged: (text) => widget.text.value = text,
              ),
            );
          },
        ),
      );

  Widget _suffixIcon() {
    switch (widget.textFieldType) {
      case OdyTextFieldType.clearButton:
        return _closeButton();
      case OdyTextFieldType.textCounter:
        return _textCounter(widget.text.value);
      case OdyTextFieldType.none:
        return const SizedBox.shrink();
    }
  }

  Widget _closeButton() => IconButton(
        padding: const EdgeInsets.only(left: 20),
        icon: SvgPicture.asset(CommonImages.icRoundCancel),
        iconSize: 24,
        onPressed: () {
          widget.text.value = "";
          _textFieldController.text = "";
        },
        highlightColor: Colors.transparent,
      );

  Widget _textCounter(String text) => Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Text(
          "${text.length}/15",
          style: PretendardFonts.medium16.copyWith(
            color: CommonColors.gray_350,
          ),
        ),
      );

  UnderlineInputBorder _inputBorder() => const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: CommonColors.purple_800,
        ),
      );
}
