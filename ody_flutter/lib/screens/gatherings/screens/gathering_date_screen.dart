import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/components/ody_button.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/screens/gatherings/gathering_creator_view_model.dart";
import "package:table_calendar/table_calendar.dart";

class GatheringDateScreen extends StatelessWidget {
  GatheringDateScreen({required this.viewModel, super.key});

  final GatheringCreatorViewModel viewModel;

  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, Widget? child) {
          final children = [
            OdyHighlightText(
              text: "언제 만나시나요?",
              highlightText: "언제",
              textStyle: PretendardFonts.bold24.copyWith(
                color: CommonColors.gray_800,
              ),
              highlightStyle: PretendardFonts.bold24.copyWith(
                color: CommonColors.purple_800,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListenableBuilder(
                listenable: _focusedDay,
                builder: (BuildContext context, Widget? child) => Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: TableCalendar(
                    locale: "ko_KR",
                    rowHeight: 50,
                    focusedDay: _focusedDay.value,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),
                    calendarStyle: CalendarStyle(
                      selectedDecoration: const BoxDecoration(
                        color: CommonColors.purple_800,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: PretendardFonts.regular14.copyWith(
                        color: CommonColors.black,
                      ),
                    ),
                    onDaySelected: (_, focusedDay) =>
                        _focusedDay.value = focusedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(_focusedDay.value, day),
                    availableGestures: AvailableGestures.none,
                  ),
                ),
              ),
            ),
            const Spacer(),
            OdyButton(
              buttonType: OdyButtonType.next,
              onPressed: () {},
              isEnabled: ValueNotifier(true),
            ),
            const SizedBox(
              height: 10,
            ),
          ];
          return Scaffold(
            backgroundColor: CommonColors.white,
            body: SafeArea(
              child: ColoredBox(
                color: CommonColors.white,
                child: Column(
                  children: children,
                ),
              ),
            ),
          );
        },
      );
}
