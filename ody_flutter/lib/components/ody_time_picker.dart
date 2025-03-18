import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";

class OdyTimePicker extends StatefulWidget {
  const OdyTimePicker({super.key});

  @override
  State<OdyTimePicker> createState() => _OdyTimePickerState();
}

class _OdyTimePickerState extends State<OdyTimePicker> {
  int selectedHour = TimeOfDay.now().hour;
  int selectedMinute = TimeOfDay.now().minute;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          _timerTextWidget(
            List.generate(24, (index) => index.toString().padLeft(2, "0")),
            selectedHour,
            (value) => setState(() => selectedHour = int.parse(value)),
          ),
          const Text(
            " : ",
            style: PretendardFonts.bold24,
          ),
          _timerTextWidget(
            List.generate(60, (index) => index.toString().padLeft(2, "0")),
            selectedMinute,
            (value) => setState(() => selectedMinute = int.parse(value)),
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

  Widget _divider() => Container(
        height: 2,
        color: CommonColors.purple_300,
      );
}
