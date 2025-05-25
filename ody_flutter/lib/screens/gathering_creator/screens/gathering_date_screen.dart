import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/components/ody_highlight_text.dart";
import "package:ody_flutter/screens/gathering_creator/gathering_creator_view_model.dart";
import "package:table_calendar/table_calendar.dart";

class GatheringDateScreen extends StatelessWidget {
  const GatheringDateScreen({
    required this.viewModel,
    super.key,
  });

  final GatheringCreatorViewModel viewModel;

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
        listenable: viewModel.date,
        builder: (BuildContext context, Widget? child) => Scaffold(
          backgroundColor: CommonColors.cream,
          body: SafeArea(
            child: ColoredBox(
              color: CommonColors.cream,
              child: Column(
                children: [
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: TableCalendar(
                        locale: "ko_KR",
                        rowHeight: 50,
                        focusedDay: viewModel.date.value,
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
                            viewModel.date.value = focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(viewModel.date.value, day),
                        availableGestures: AvailableGestures.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
