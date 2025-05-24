import "package:flutter/cupertino.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";

class OdyTimePicker extends StatefulWidget {
  const OdyTimePicker({
    required this.selectedHour,
    required this.selectedMinute,
    super.key,
  });

  final ValueNotifier<int> selectedHour;
  final ValueNotifier<int> selectedMinute;

  @override
  State<OdyTimePicker> createState() => _OdyTimePickerState();
}

class _OdyTimePickerState extends State<OdyTimePicker> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          _timerTextWidget(
            List.generate(
              24,
              (index) => index.toString().padLeft(2, "0"),
            ),
            widget.selectedHour.value,
            (value) => setState(
              () => widget.selectedHour.value = int.parse(value),
            ),
          ),
          const Text(
            " : ",
            style: PretendardFonts.bold24,
          ),
          _timerTextWidget(
            List.generate(
              60,
              (index) => index.toString().padLeft(2, "0"),
            ),
            widget.selectedMinute.value,
            (value) => setState(
              () => widget.selectedMinute.value = int.parse(value),
            ),
          ),
        ],
      );

  Widget _timerTextWidget(
    List<String> items,
    int selectedValue,
    ValueChanged<String> onSelected,
  ) =>
      SizedBox(
        width: 60,
        child: CupertinoPicker(
          scrollController:
              FixedExtentScrollController(initialItem: selectedValue),
          itemExtent: 60,
          onSelectedItemChanged: (index) => onSelected(items[index]),
          children: items.map((item) {
            final isSelected = int.parse(item) == selectedValue;
            return Center(
              child: Text(
                item,
                style: PretendardFonts.medium24.copyWith(
                  color:
                      isSelected ? CommonColors.black : CommonColors.gray_800,
                ),
              ),
            );
          }).toList(),
        ),
      );
}
