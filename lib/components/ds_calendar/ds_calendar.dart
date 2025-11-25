import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../design_system_project.dart';

/// Selection mode for the calendar
enum DSCalendarSelectionMode {
  /// Single date selection mode
  single,

  /// Date range selection mode
  range,
}

/// A customizable calendar widget with single date and range selection support
class DSCalendar extends StatefulWidget {
  final Locale locale;

  /// Selection mode: single date or range
  final DSCalendarSelectionMode selectionMode;

  /// Callback when date range is selected (for range mode)
  final void Function(DateTime? start, DateTime? end)? onRangeSelected;

  /// Callback when single date is selected (for single mode)
  final void Function(DateTime? date)? onDateSelected;

  /// Initial selected start date (for range mode)
  final DateTime? initialStartDate;

  /// Initial selected end date (for range mode)
  final DateTime? initialEndDate;

  /// Initial selected date (for single mode)
  final DateTime? initialSelectedDate;

  /// Min date
  final DateTime? minDate;

  /// Max date
  final DateTime? maxDate;

  const DSCalendar({
    super.key,
    this.locale = AppLocaleSupportConstants.vi,
    this.selectionMode = DSCalendarSelectionMode.range,
    this.onRangeSelected,
    this.onDateSelected,
    this.initialStartDate,
    this.initialEndDate,
    this.initialSelectedDate,
    this.minDate,
    this.maxDate,
  });

  @override
  State<DSCalendar> createState() => _DSCalendarState();
}

class _DSCalendarState extends DSStateBase<DSCalendar> {
  // ===========================================================================
  // CONSTANTS
  // ===========================================================================
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const int _yearJump = 12;
  static final DateTime _defaultMinDate = DateTime(1990, 1, 1);
  static final DateTime _defaultMaxDate = DateTime(2099, 12, 31);

  // ===========================================================================
  // THEME & STYLING
  // ===========================================================================
  late DSCalendarTheme componentTheme =
      theme.extension<DSCalendarThemeExtension>()!.dSCalendarTheme;

  // ===========================================================================
  // STATE MANAGEMENT
  // ===========================================================================
  final selectedDateNotifier = ValueNotifier<DateTime?>(null);
  final selectedStartDayNotifier = ValueNotifier<DateTime?>(null);
  final selectedEndDayNotifier = ValueNotifier<DateTime?>(null);
  final focusedDayNotifier = ValueNotifier<DateTime?>(DateTime.now());

  // ===========================================================================
  // CONTROLLERS
  // ===========================================================================
  late PageController _pageController;

  // ===========================================================================
  // COMPUTED PROPERTIES
  // ===========================================================================
  DateTime get _firstDay {
    final _minDate = widget.minDate ?? _defaultMinDate;
    final _initialStart = widget.initialStartDate;
    final _initialEnd = widget.initialEndDate;
    final _initialSelected = widget.initialSelectedDate;
    DateTime? _candidate = _minDate;

    if (_initialStart != null && _initialStart.isBefore(_candidate)) {
      _candidate = _initialStart;
    }
    if (_initialEnd != null && _initialEnd.isBefore(_candidate)) {
      _candidate = _initialEnd;
    }
    if (_initialSelected != null && _initialSelected.isBefore(_candidate)) {
      _candidate = _initialSelected;
    }
    return _candidate;
  }

  DateTime get _lastDay {
    final _maxDate = widget.maxDate ?? _defaultMaxDate;
    final _initialStart = widget.initialStartDate;
    final _initialEnd = widget.initialEndDate;
    final _initialSelected = widget.initialSelectedDate;
    DateTime? _candidate = _maxDate;

    if (_initialStart != null && _initialStart.isAfter(_candidate)) {
      _candidate = _initialStart;
    }
    if (_initialEnd != null && _initialEnd.isAfter(_candidate)) {
      _candidate = _initialEnd;
    }
    if (_initialSelected != null && _initialSelected.isAfter(_candidate)) {
      _candidate = _initialSelected;
    }
    return _candidate;
  }

  // ===========================================================================
  // LIFECYCLE METHODS
  // ===========================================================================
  @override
  void initState() {
    super.initState();
    if (widget.selectionMode == DSCalendarSelectionMode.range) {
      selectedStartDayNotifier.value = widget.initialStartDate;
      selectedEndDayNotifier.value = widget.initialEndDate;
    } else {
      selectedDateNotifier.value = widget.initialSelectedDate;
    }
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
          ],
        );
      },
    );
  }

  // ===========================================================================
  // UI BUILDING METHODS
  // ===========================================================================

  /// Builds the calendar header with navigation controls.
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
        padding: EdgeInsets.all(componentTheme.navigationIconPadding),
        child: Icon(
          icon,
          size: componentTheme.navigationIconSize,
          color: componentTheme.navigationIconColor,
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
            style: componentTheme.headerTextStyle,
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
      rangeStartDay: widget.selectionMode == DSCalendarSelectionMode.range
          ? selectedStartDayNotifier.value
          : null,
      rangeEndDay: widget.selectionMode == DSCalendarSelectionMode.range
          ? selectedEndDayNotifier.value
          : null,
      selectedDayPredicate: _isDaySelected,
      rangeSelectionMode: widget.selectionMode == DSCalendarSelectionMode.range
          ? RangeSelectionMode.toggledOn
          : RangeSelectionMode.disabled,
      daysOfWeekHeight: componentTheme.dayOfWeekHeight,
      calendarBuilders: _buildCalendarBuilders(),
      onRangeSelected: widget.selectionMode == DSCalendarSelectionMode.range
          ? _onRangeSelected
          : null,
      onDaySelected: widget.selectionMode == DSCalendarSelectionMode.single
          ? _onDaySelected
          : null,
      calendarStyle: componentTheme.calendarStyle,
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
    if (label == null) {
      return null;
    }

    return Center(
      child: Text(
        label,
        style: textTheme.base?.medium
                .copyWith(color: DSColorUsages.text.tertiary) ??
            const TextStyle(),
      ),
    );
  }

  // ===========================================================================
  // NAVIGATION METHODS
  // ===========================================================================
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

  // ===========================================================================
  // EVENT HANDLERS
  // ===========================================================================
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    selectedStartDayNotifier.value = start;
    selectedEndDayNotifier.value = end;
    widget.onRangeSelected?.call(start, end);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDateNotifier.value = selectedDay;
    widget.onDateSelected?.call(selectedDay);
  }

  bool _isDaySelected(DateTime day) {
    if (widget.selectionMode == DSCalendarSelectionMode.range) {
      return (selectedStartDayNotifier.value?.isSameDay(day) ?? false) ||
          (selectedEndDayNotifier.value?.isSameDay(day) ?? false);
    } else {
      return selectedDateNotifier.value?.isSameDay(day) ?? false;
    }
  }

  List<DateTime> _getEventsForDay(DateTime day) {
    return [if (DateTime.now().isSameDay(day)) day];
  }
}
