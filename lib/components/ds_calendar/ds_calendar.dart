import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../design_system_project.dart';

/// A customizable calendar widget with range selection support
class DSCalendar extends StatefulWidget {
  final Locale locale;

  /// Callback when date range is selected
  final void Function(DateTime? start, DateTime? end)? onRangeSelected;

  /// Initial selected start date
  final DateTime? initialStartDate;

  /// Initial selected end date
  final DateTime? initialEndDate;

  const DSCalendar({
    super.key,
    this.locale = AppLocaleSupportConstants.vi,
    this.onRangeSelected,
    this.initialStartDate,
    this.initialEndDate,
  });

  @override
  State<DSCalendar> createState() => _DSCalendarState();
}

class _DSCalendarState extends DSStateBase<DSCalendar> {
  // Constants
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const double _iconSize = 24.0;
  static const double _iconPadding = 16.0;
  static const double _daysOfWeekHeight = 40.0;
  static const double _markerSize = 5.0;
  static const double _dateDisplayFontSize = 16.0;
  static const int _yearJump = 12;

  // Date range constants
  static final DateTime _firstDay = DateTime(1990, 1, 1);
  static final DateTime _lastDay = DateTime(2099, 12, 31);

  // State management
  late DSCalendarTheme componentTheme =
      theme.extension<DSCalendarThemeExtension>()!.dSCalendarTheme;

  final selectedDateNotifier = ValueNotifier<DateTime?>(null);
  final selectedStartDayNotifier = ValueNotifier<DateTime?>(null);
  final selectedEndDayNotifier = ValueNotifier<DateTime?>(null);
  final focusedDayNotifier = ValueNotifier<DateTime?>(DateTime.now());

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    selectedStartDayNotifier.value = widget.initialStartDate;
    selectedEndDayNotifier.value = widget.initialEndDate;
  }

  @override
  void dispose() {
    selectedDateNotifier.dispose();
    selectedStartDayNotifier.dispose();
    selectedEndDayNotifier.dispose();
    focusedDayNotifier.dispose();
    super.dispose();
  }

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
            _buildCalendarHeader(),
            _buildTableCalendar(),
            const SizedBox(height: 16),
            _buildDateRangeDisplay(),
          ],
        );
      },
    );
  }

  /// Builds the calendar header with navigation controls
  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNavigationButton(
          icon: Icons.keyboard_double_arrow_left_rounded,
          onTap: _jumpToPreviousYear,
        ),
        _buildNavigationButton(
          icon: Icons.keyboard_arrow_left_rounded,
          onTap: _goToPreviousMonth,
        ),
        _buildMonthYearDisplay(),
        _buildNavigationButton(
          icon: Icons.keyboard_arrow_right_rounded,
          onTap: _goToNextMonth,
        ),
        _buildNavigationButton(
          icon: Icons.keyboard_double_arrow_right_rounded,
          onTap: _jumpToNextYear,
        ),
      ],
    );
  }

  /// Builds a navigation button
  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(_iconPadding),
        child: Icon(
          icon,
          size: _iconSize,
          color: DSColorUsages.icon.brand,
        ),
      ),
    );
  }

  /// Builds the month/year display
  Widget _buildMonthYearDisplay() {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: focusedDayNotifier,
        builder: (context, value, child) {
          if (value == null) {
            return const SizedBox.shrink();
          }

          final date = DateTime(value.year, value.month, 1);
          return Text(
            date.toLocalmmCommayyyy(),
            style: textTheme.base?.medium,
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }

  /// Builds the table calendar
  Widget _buildTableCalendar() {
    return TableCalendar(
      onCalendarCreated: (controller) => _pageController = controller,
      locale: widget.locale.toString(),
      onPageChanged: (DateTime focusedDay) {
        focusedDayNotifier.value = focusedDay;
      },
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Tháng',
      },
      headerVisible: false,
      startingDayOfWeek: StartingDayOfWeek.monday,
      focusedDay: DateTime.now(),
      firstDay: _firstDay,
      lastDay: _lastDay,
      rangeStartDay: selectedStartDayNotifier.value,
      rangeEndDay: selectedEndDayNotifier.value,
      rangeSelectionMode: RangeSelectionMode.toggledOn,
      daysOfWeekHeight: _daysOfWeekHeight,
      calendarBuilders: _buildCalendarBuilders(),
      onRangeSelected: _onRangeSelected,
      selectedDayPredicate: _isDaySelected,
      calendarStyle: _buildCalendarStyle(),
      eventLoader: _getEventsForDay,
    );
  }

  /// Builds calendar builders for custom styling
  CalendarBuilders _buildCalendarBuilders() {
    return CalendarBuilders(
      dowBuilder: _buildDayOfWeek,
    );
  }

  /// Builds day of week labels
  Widget? _buildDayOfWeek(BuildContext context, DateTime day) {
    final dayLabels = {
      DateTime.monday: 'T2',
      DateTime.tuesday: 'T3',
      DateTime.wednesday: 'T4',
      DateTime.thursday: 'T5',
      DateTime.friday: 'T6',
      DateTime.saturday: 'T7',
      DateTime.sunday: 'CN',
    };

    final label = dayLabels[day.weekday];
    if (label == null) return null;

    return Center(
      child: Text(
        label,
        style: textTheme.base?.medium
                .copyWith(color: DSColorUsages.text.tertiary) ??
            const TextStyle(),
      ),
    );
  }

  /// Builds calendar style
  CalendarStyle _buildCalendarStyle() {
    return CalendarStyle(
      markerSize: _markerSize,
      outsideDaysVisible: false,
      markerDecoration: BoxDecoration(
        color: DSColorUsages.icon.brand,
        shape: BoxShape.circle,
      ),
      todayDecoration: BoxDecoration(
        color: colors.transparent,
        shape: BoxShape.circle,
      ),
      todayTextStyle:
          textTheme.base?.regular.copyWith(color: DSColorUsages.text.linkRed) ??
              const TextStyle(),
      defaultTextStyle:
          textTheme.base?.regular.copyWith(color: DSColorUsages.text.primary) ??
              const TextStyle(),
      selectedDecoration: BoxDecoration(
        color: DSColorUsages.background.brandPrimary,
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.gray.white,
          width: 2,
        ),
      ),
      rangeHighlightColor: DSColorUsages.background.brandSecondary,
      withinRangeTextStyle:
          textTheme.base?.regular.copyWith(color: DSColorUsages.text.linkRed) ??
              const TextStyle(),
    );
  }

  /// Builds the date range display
  Widget _buildDateRangeDisplay() {
    return ValueListenableBuilder(
      valueListenable: selectedStartDayNotifier,
      builder: (context, startDate, child) {
        return ValueListenableBuilder(
          valueListenable: selectedEndDayNotifier,
          builder: (context, endDate, child) {
            if (startDate == null && endDate == null) {
              return const SizedBox.shrink();
            }

            final startText = startDate != null
                ? '${startDate.day}/${startDate.month}/${startDate.year}'
                : '';
            final endText = endDate != null
                ? '${endDate.day}/${endDate.month}/${endDate.year}'
                : '';

            return Text(
              '$startText - $endText',
              style: const TextStyle(fontSize: _dateDisplayFontSize),
            );
          },
        );
      },
    );
  }

  // Navigation methods
  void _goToPreviousMonth() {
    _pageController.previousPage(
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  void _goToNextMonth() {
    _pageController.nextPage(
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  void _jumpToPreviousYear() {
    _pageController.animateToPage(
      (_pageController.page ?? 0).floor() - _yearJump,
      duration: _animationDuration,
      curve: Curves.easeOut,
    );
  }

  void _jumpToNextYear() {
    _pageController.animateToPage(
      (_pageController.page ?? 0).floor() + _yearJump,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  // Event handlers
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    selectedStartDayNotifier.value = start;
    selectedEndDayNotifier.value = end;
    widget.onRangeSelected?.call(start, end);
  }

  bool _isDaySelected(DateTime day) {
    return (selectedStartDayNotifier.value?.isSameDay(day) ?? false) ||
        (selectedEndDayNotifier.value?.isSameDay(day) ?? false);
  }

  List<DateTime> _getEventsForDay(DateTime day) {
    return [if (DateTime.now().isSameDay(day)) day];
  }
}
