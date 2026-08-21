// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../base/ds_base.dart';
import '../../constants/constants.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../gen/assets.gen.dart';
import '../../theme/ds_theme.dart';
import '../../utils/helpers.dart';
import '../ds_components.dart';

/// A modern screen form component with blur effect app bar.
///
/// This component provides a modern UI with a blur effect app bar, similar to iOS design.
/// It includes an app bar with title, back button, and a body area for form content.
/// It automatically handles status bar styling and keyboard dismissal.
class DSBasicScreenForm extends StatefulWidget {
  /// The title displayed in the app bar.
  ///
  /// Defaults to empty string if not provided.
  final String? title;

  /// The main content widget displayed in the body area.
  ///
  /// Defaults to [SizedBox] if not provided.
  final Widget? child;

  /// Background color for the entire screen.
  ///
  /// Defaults to [DSColorUsages.background.secondary] if not provided.
  final Color? backgroundColor;

  /// Background color for the app bar.
  ///
  /// Defaults to [DSColorUsages.background.brandPrimary] if not provided.
  final Color? appbarColor;

  /// Foreground color for app bar text and icons.
  ///
  /// Defaults to [DSColorUsages.text.white] if not provided.
  final Color? appbarForegroundColor;

  /// List of action widgets displayed in the app bar.
  ///
  /// Defaults to empty list.
  final List<Widget> actions;

  /// Callback function for back button press.
  ///
  /// Defaults to [Navigator.pop] if not provided.
  final void Function()? onBack;

  /// Whether the body should resize when keyboard appears.
  ///
  /// Defaults to true if not provided.
  final bool? resizeToAvoidBottomInset;

  /// Whether to show the back button.
  ///
  /// Defaults to true if not provided.
  final bool? showBackButton;

  /// Custom back button widget.
  ///
  /// If not provided, uses default back button with chevron icon.
  final Widget? backButton;

  /// Whether to center the title.
  ///
  /// Defaults to true if not provided.
  final bool? centerTitle;

  /// Maximum number of lines for the title.
  ///
  /// Defaults to 1 if not provided.
  final int? titleMaxLines;

  /// Custom text style for the title.
  ///
  /// Defaults to [textTheme.lg?.semibold] with white color if not provided.
  final DSTextStyle? titleStyle;

  /// Whether to enable blur effect, defaults to true
  final bool enableBlur;

  /// The maximum blur opacity, defaults to 0.7
  final double maxBlurOpacity;

  /// The padding of the child, defaults to 0
  final EdgeInsets? padding;

  /// Result to return when back button is pressed
  final dynamic result;

  /// Whether to automatically pop with result when back is pressed
  final bool popWithResult;

  /// The widget to display at the bottom of the screen
  final Widget? bottomWidget;

  /// Custom padding for the child
  final EdgeInsets Function(EdgeInsets padding)? onCustomPadding;

  /// A button displayed floating above the body, in the bottom right corner.
  ///
  /// Typically a [FloatingActionButton].
  ///
  /// Optional - only shown if provided.
  final Widget? floatingActionButton;

  /// Responsible for determining where the [floatingActionButton] should go.
  ///
  /// If null, the [ScaffoldState] will use the default location,
  /// [FloatingActionButtonLocation.endFloat].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Animator to move the [floatingActionButton] to
  /// a new [FloatingActionButtonLocation].
  ///
  /// If null, the [ScaffoldState] will use the default animator,
  /// [FloatingActionButtonAnimator.scaling].
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  ///
  /// Snack bars slide from underneath the bottom navigation bar while bottom
  /// sheets are stacked on top.
  ///
  /// The [bottomNavigationBar] is rendered below the [persistentFooterButtons]
  /// and the [body].
  ///
  /// Optional - only shown if provided.
  final Widget? bottomNavigationBar;

  /// Whether to use safe area, defaults to true
  final bool? useSafeArea;

  /// Creates a modern screen form widget with blur effect.
  ///
  /// All parameters are optional and have sensible defaults based on the design system.
  /// The component automatically handles status bar styling and keyboard dismissal.
  const DSBasicScreenForm({
    super.key,
    this.title,
    this.child,
    this.backgroundColor,
    this.appbarColor,
    this.appbarForegroundColor,
    this.actions = const <Widget>[],
    this.onBack,
    this.resizeToAvoidBottomInset,
    this.showBackButton,
    this.backButton,
    this.centerTitle,
    this.titleMaxLines,
    this.titleStyle,
    this.enableBlur = true,
    this.maxBlurOpacity = 0.7,
    this.padding,
    this.result,
    this.popWithResult = false,
    this.bottomWidget,
    this.onCustomPadding,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.bottomNavigationBar,
    this.useSafeArea = true,
  });

  /// Creates a standardized app bar action button with consistent styling.
  ///
  /// This method creates an action button that follows the same design pattern
  /// as the back button, with proper styling, touch area, and visual feedback.
  /// The button uses the same styling approach as the back button in this component.
  ///
  /// [icon] The icon path to display in the button. Should be a [DSAssets] icon path (e.g., DSAssets.vuesax.searchNormal1Linear).
  /// [onPressed] Callback function when the button is pressed.
  /// [iconColor] Optional custom color for the icon. Defaults to the app bar foreground color.
  /// [iconSize] Optional custom size for the icon. Defaults to 20x20 (same as back button).
  /// [splashRadius] Optional custom splash radius. Defaults to 20 (same as back button).
  ///
  /// Returns a [Widget] that can be added to the actions list.
  static Widget createAppBarActionButton({
    required String icon,
    required VoidCallback onPressed,
    Color? iconColor,
    double? iconSize,
    double? splashRadius,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final componentTheme = theme
            .extension<DSBasicScreenFormThemeExtension>()!
            .dSBasicScreenFormTheme;

        final effectiveIconColor =
            iconColor ?? componentTheme.appbarForegroundColor;
        final effectiveIconSize = iconSize ?? DSIconSizes.size24;
        final effectiveSplashRadius = splashRadius ?? 20;

        return IconButton(
          icon: DSImageView(
            source: icon,
            height: effectiveIconSize,
            width: effectiveIconSize,
            color: effectiveIconColor,
          ),
          onPressed: onPressed,
          splashRadius: effectiveSplashRadius,
        );
      },
    );
  }

  @override
  State<DSBasicScreenForm> createState() => _DSBasicScreenFormState();
}

class _DSBasicScreenFormState extends DSStateBase<DSBasicScreenForm> {
  late DSBasicScreenFormTheme componentTheme = theme
      .extension<DSBasicScreenFormThemeExtension>()!
      .dSBasicScreenFormTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateStatusBar();
  }

  /// Updates the status bar style.
  ///
  /// Sets light status bar for this basic form.
  void _updateStatusBar() {
    setLightStatusBar();
  }

  /// Determines whether the title should be centered.
  ///
  /// Returns true if [centerTitle] is true.
  bool get isCenterTitle => componentTheme.centerTitle;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;

    return Scaffold(
      backgroundColor: widget.backgroundColor ?? componentTheme.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: Stack(
        children: [
          // Main content
          _buildBody(),
          // Blur effect container behind AppBar
          if (widget.enableBlur)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    height: topPadding + kToolbarHeight,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: widget.maxBlurOpacity,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          // AppBar on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: DSColorUsages.border.secondary,
                      width: 0.5,
                    ),
                  ),
                ),
                child: _buildAppBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the main body content
  Widget _buildBody() {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top + kToolbarHeight;
    final bottomPadding = mediaQuery.padding.bottom;

    final defaultPadding = (widget.padding ?? EdgeInsets.zero).let(
          (it) => it?.copyWith(
            top: topPadding + (it.top),
            bottom: widget.useSafeArea == true && widget.bottomWidget == null
                ? max(bottomPadding, it.bottom)
                : it.bottom,
          ),
        ) ??
        EdgeInsets.zero;

    final customPadding =
        widget.onCustomPadding?.call(defaultPadding) ?? defaultPadding;

    Widget bodyWidget;

    if (_isChildScrollable) {
      // If child is scrollable, wrap it with padding
      bodyWidget = Padding(padding: customPadding, child: widget.child);
    } else if (_hasExpandedChildren) {
      // If child has Expanded widgets, wrap with SafeArea and padding
      bodyWidget = Padding(padding: customPadding, child: widget.child);
    } else {
      // If child is not scrollable, wrap it with ListView
      bodyWidget = ListView(
        padding: customPadding,
        children: [widget.child ?? const SizedBox()],
      );
    }

    if (widget.bottomWidget != null) {
      bodyWidget = Column(
        children: [
          Expanded(child: bodyWidget),
          widget.bottomWidget!,
        ],
      );
    }

    return bodyWidget;
  }

  /// Check if the child is a scrollable widget
  bool get _isChildScrollable {
    return widget.child is ListView ||
        widget.child is SingleChildScrollView ||
        widget.child is CustomScrollView ||
        widget.child is GridView ||
        widget.child is PageView ||
        widget.child is TabBarView;
  }

  /// Check if the child contains Expanded widgets that need special handling
  bool get _hasExpandedChildren {
    if (widget.child is Column) {
      final column = widget.child as Column;
      return column.children.any((child) => child is Expanded);
    }
    return false;
  }

  /// Default leading widget (back button)
  Widget get _defaultLeading {
    if (!(widget.showBackButton ?? true)) {
      return const SizedBox.shrink();
    }

    // Check if we can pop from current route
    final navigator = Navigator.of(context);

    // Check if there's a dialog or overlay showing
    // We can detect this by checking if the current route is not the topmost
    final currentRoute = ModalRoute.of(context);
    final isTopRoute = currentRoute?.isCurrent == true;

    // Don't show back button if:
    // 1. Can't pop (no previous routes)
    // 2. There's a dialog/overlay showing (back button would be covered)
    if (!navigator.canPop() || !isTopRoute) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: DSImageView(
        source: DSAssets.vuesax.arrowLeft2Linear,
        height: DSIconSizes.size24,
        width: DSIconSizes.size24,
        color: componentTheme.appbarForegroundColor,
      ),
      onPressed: _handleBackPress,
      splashRadius: 20,
    );
  }

  /// Handle back button press with proper navigation logic
  void _handleBackPress() {
    // If custom back handler is provided, use it
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }

    final navigator = Navigator.of(context);

    // If popWithResult is true and result is provided, pop with result
    if (widget.popWithResult && widget.result != null) {
      navigator.pop(widget.result);
      return;
    }

    // Check if we can pop from current route
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      // If can't pop, try to go to home or show dialog
      _showBackConfirmationDialog();
    }
  }

  /// Show confirmation dialog when back navigation is not possible
  void _showBackConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Exit app
                SystemNavigator.pop();
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  /// Builds the app bar widget with title, back button, and actions.
  ///
  /// The app bar includes:
  /// - Status bar padding
  /// - Back button (if enabled)
  /// - Title
  /// - Action buttons
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 1,
      actionsPadding: const EdgeInsets.only(right: 4),
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      scrolledUnderElevation: 0,
      leading: widget.backButton ?? _defaultLeading,
      actions: widget.actions,
      centerTitle: widget.centerTitle ?? true,
      foregroundColor: componentTheme.titleStyle?.color,
      title: _buildTitle(),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.title ?? '',
      style: widget.titleStyle ?? componentTheme.titleStyle,
      maxLines: widget.titleMaxLines ?? 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
