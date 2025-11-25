part of '../../ds_theme.dart';

// ============================================================================
// ENUMS
// ============================================================================
enum DSCalendarVariants {
  primary,
  secondary,
  outline,
  ghost,
  // TODO(thq4n): Define variants for DSCalendar component
}

// ============================================================================
// THEME EXTENSION
// ============================================================================
class DSCalendarThemeExtension
    extends ThemeExtension<DSCalendarThemeExtension> {
  final DSTextTheme textTheme;
  final DSColors colors = const DSColors();

  DSCalendarThemeExtension({required this.textTheme});

  // ===========================================================================
  // THEME GENERATION
  // ===========================================================================
  DSCalendarTheme get dSCalendarTheme {
    // =========================================================================
    // HEADER STYLING
    // =========================================================================
    final headerTextStyle = textTheme.base?.medium ?? DSTextStyle();
    final navigationIconColor = DSColorUsages.icon.brand;
    final navigationIconSize = DSIconSizes.size24;
    const navigationIconPadding = 8.0;

    // =========================================================================
    // DAY OF WEEK STYLING
    // =========================================================================
    final dayOfWeekTextStyle = DSTextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: DSColorUsages.text.tertiary,
    );
    final dayOfWeekHeight = DSIconSizes.size40;

    // =========================================================================
    // CALENDAR STYLING
    // =========================================================================
    const markerSize = 5.0;
    final markerDecoration = BoxDecoration(
      color: DSColorUsages.icon.brand,
      shape: BoxShape.circle,
    );
    final todayDecoration = BoxDecoration(
      color: colors.transparent,
      shape: BoxShape.circle,
    );
    final todayTextStyle = textTheme.base?.regular.copyWith(
          color: DSColorUsages.text.linkRed,
        ) ??
        const TextStyle();
    final defaultTextStyle = textTheme.base?.regular.copyWith(
          color: DSColorUsages.text.primary,
        ) ??
        const TextStyle();
    final selectedDecoration = BoxDecoration(
      color: DSColorUsages.background.brandPrimary,
      shape: BoxShape.circle,
      border: Border.all(
        color: colors.gray.white,
        width: 2,
      ),
    );
    final rangeHighlightColor = DSColorUsages.background.brandSecondary;
    final withinRangeTextStyle = textTheme.base?.regular.copyWith(
          color: DSColorUsages.text.linkRed,
        ) ??
        const TextStyle();

    final calendarStyle = CalendarStyle(
      markerSize: markerSize,
      outsideDaysVisible: true,
      markerDecoration: markerDecoration,
      todayDecoration: todayDecoration,
      todayTextStyle: todayTextStyle,
      defaultTextStyle: defaultTextStyle,
      selectedDecoration: selectedDecoration,
      rangeHighlightColor: rangeHighlightColor,
      withinRangeTextStyle: withinRangeTextStyle,
    );

    return DSCalendarTheme(
      headerTextStyle: headerTextStyle,
      navigationIconColor: navigationIconColor,
      navigationIconSize: navigationIconSize,
      navigationIconPadding: navigationIconPadding,
      dayOfWeekTextStyle: dayOfWeekTextStyle,
      dayOfWeekHeight: dayOfWeekHeight,
      calendarStyle: calendarStyle,
    );
  }

  // ===========================================================================
  // THEME EXTENSION METHODS
  // ===========================================================================
  @override
  ThemeExtension<DSCalendarThemeExtension> copyWith() {
    return DSCalendarThemeExtension(textTheme: textTheme);
  }

  @override
  ThemeExtension<DSCalendarThemeExtension> lerp(
    covariant DSCalendarThemeExtension? other,
    double t,
  ) {
    return DSCalendarThemeExtension(
      textTheme: textTheme.lerp(other?.textTheme, t),
    );
  }
}
