import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../design_system_project.dart';

class DSCalendar extends StatefulWidget {
  final DSCalendarVariants variant;
  const DSCalendar({super.key, this.variant = DSCalendarVariants.primary});

  @override
  State<DSCalendar> createState() => _DSCalendarState();
}

class _DSCalendarState extends DSStateBase<DSCalendar> {
  late DSCalendarTheme componentTheme =
      theme.extension<DSCalendarThemeExtension>()!.dSCalendarTheme;

  final selectedDateNotifier = ValueNotifier<DateTime?>(null);
  final selectedStartDayNotifier = ValueNotifier<DateTime?>(null);
  final selectedEndDayNotifier = ValueNotifier<DateTime?>(null);
  final focusedDayNotifier = ValueNotifier<DateTime?>(DateTime.now());
  late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        selectedDateNotifier,
        selectedStartDayNotifier,
        selectedEndDayNotifier,
      ]),
      builder: (context, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _pageController.animateToPage(
                    (_pageController.page ?? 0).floor() - 12, // lù i 12 tháng
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.keyboard_double_arrow_left_rounded,
                      size: 24,
                      color: DSColorUsages.icon.brand,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.keyboard_arrow_left_rounded,
                      size: 24,
                      color: DSColorUsages.icon.brand,
                    ),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: focusedDayNotifier,
                    builder: (context, value, child) {
                      if (value == null) {
                        return const SizedBox.shrink();
                      }
                      final month = value.month;
                      final year = value.year;
                      return Text(
                        'Tháng $month, $year',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 24,
                      color: DSColorUsages.icon.brand,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _pageController.animateToPage(
                    (_pageController.page ?? 0).floor() + 12, // lùi 12 tháng
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.keyboard_double_arrow_right_rounded,
                      size: 24,
                      color: DSColorUsages.icon.brand,
                    ),
                  ),
                ),
              ],
            ),
            TableCalendar(
              onCalendarCreated: (controller) => _pageController = controller,
              locale: 'vi_VN',
              onPageChanged: (DateTime focusedDay) {
                focusedDayNotifier.value = focusedDay;
              },
              calendarFormat: CalendarFormat.month,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Tháng',
              },
              headerVisible: false,
              startingDayOfWeek: StartingDayOfWeek.monday,

              // currentDay: selectedDateNotifier.value ?? DateTime.now(),
              focusedDay: DateTime.now(),
              firstDay: DateTime(1990, 1, 1),
              lastDay: DateTime(2099, 12, 31),

              // onDaySelected: (DateTime day, DateTime focusedDay) {
              //   selectedDateNotifier.value = day;
              // },
              rangeStartDay: selectedStartDayNotifier.value,
              rangeEndDay: selectedEndDayNotifier.value,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              onRangeSelected:
                  (DateTime? start, DateTime? end, DateTime focusedDay) {
                selectedStartDayNotifier.value = start;
                selectedEndDayNotifier.value = end;
              },
            ),
            const SizedBox(height: 16),
            Text(
              '${selectedStartDayNotifier.value?.day}/${selectedStartDayNotifier.value?.month}/${selectedStartDayNotifier.value?.year} - ${selectedEndDayNotifier.value?.day}/${selectedEndDayNotifier.value?.month}/${selectedEndDayNotifier.value?.year}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }
}
