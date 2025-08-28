// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../base/ds_base.dart';
import '../../constants/constants.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../gen/assets.gen.dart';
import '../../theme/ds_theme.dart';
import '../../utils/object_utils.dart';
import '../../utils/status_bar_utils.dart';
import '../ds_components.dart';

/// A basic screen form component that provides a consistent layout for form screens.
///
/// This component includes an app bar with title, description, back button, and actions,
/// plus a body area for form content. It automatically handles status bar styling
/// and keyboard dismissal.
class DSBasicBrandScreenForm extends StatefulWidget {
  /// The title displayed in the app bar.
  ///
  /// Defaults to empty string if not provided.
  final String? title;

  /// The description displayed below the title in the app bar.
  ///
  /// Optional - only shown if provided and not empty.
  final String? description;

  /// The main content widget displayed in the body area.
  ///
  /// Defaults to [SizedBox] if not provided.
  final Widget? child;

  /// Background color for the entire screen.
  ///
  /// Defaults to [DSColorUsages.background.secondary] if not provided.
  final Color? bgColor;

  /// Background color for the app bar.
  ///
  /// Defaults to [DSColorUsages.background.brandPrimary] if not provided.
  final Color? appbarColor;

  /// Foreground color for app bar text and icons.
  ///
  /// Defaults to [DSColorUsages.text.white] if not provided.
  final Color? appbarForegroundColor;

  /// Whether to show a header image in the app bar.
  ///
  /// Defaults to false. When true, sets dark status bar.
  final bool? showHeaderImage;

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

  /// Additional widget displayed below the app bar content.
  ///
  /// Optional - only shown if provided.
  final Widget? extentions;

  /// Whether to show the back button.
  ///
  /// Defaults to true if not provided.
  final bool? showBackButton;

  /// Custom back button widget.
  ///
  /// If not provided, uses default back button with chevron icon.
  final Widget? backButton;

  /// Whether the app bar has rounded bottom corners.
  ///
  /// Defaults to false if not provided.
  final bool? hasBottomBorderRadius;

  /// Whether to center the title.
  ///
  /// Defaults to true if not provided. Automatically centers if actions <= 1
  /// and no description, unless [forceCenterTitle] is true.
  final bool? centerTitle;

  /// Whether to show a divider in the app bar.
  ///
  /// Defaults to false if not provided.
  final bool? showAppbarDivider;

  /// Force center title regardless of other conditions.
  ///
  /// Defaults to false if not provided.
  final bool? forceCenterTitle;

  /// Maximum number of lines for the title.
  ///
  /// Defaults to 1 if not provided.
  final int? titleMaxLines;

  /// Border radius for the app bar bottom corners.
  ///
  /// Defaults to 12.0 if not provided.
  final double? borderRadius;

  /// Custom text style for the title.
  ///
  /// Defaults to [textTheme.lg?.semibold] with white color if not provided.
  final DSTextStyle? titleStyle;

  /// Custom text style for the description.
  ///
  /// Defaults to [textTheme.base?.medium] with white color if not provided.
  final DSTextStyle? desStyle;

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

  /// Creates a basic screen form widget.
  ///
  /// All parameters are optional and have sensible defaults based on the design system.
  /// The component automatically handles status bar styling and keyboard dismissal.
  const DSBasicBrandScreenForm({
    super.key,
    this.title,
    this.description,
    this.child,
    this.bgColor,
    this.appbarColor,
    this.appbarForegroundColor,
    this.showHeaderImage,
    this.actions = const <Widget>[],
    this.onBack,
    this.resizeToAvoidBottomInset,
    this.extentions,
    this.showBackButton,
    this.backButton,
    this.hasBottomBorderRadius,
    this.centerTitle,
    this.showAppbarDivider,
    this.forceCenterTitle,
    this.titleMaxLines,
    this.borderRadius,
    this.titleStyle,
    this.desStyle,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.bottomNavigationBar,
  });

  /// Creates a standardized app bar action button with consistent styling.
  ///
  /// This method creates an action button that follows the same design pattern
  /// as the back button, with proper styling, touch area, and visual feedback.
  ///
  /// [icon] The icon path to display in the button. Should be a [DSAssets] icon path (e.g., DSAssets.vuesax.searchNormal1Linear).
  /// [onPressed] Callback function when the button is pressed.
  /// [iconColor] Optional custom color for the icon. Defaults to white.
  /// [backgroundColor] Optional custom background color. Defaults to overlay with 0.1 opacity.
  /// [iconSize] Optional custom size for the icon. Defaults to 24x24.
  /// [buttonSize] Optional custom size for the button container. Defaults to 40x40.
  /// [margin] Optional custom margin around the button. Defaults to 10px all sides.
  /// [padding] Optional custom padding inside the button. Defaults to 6px all sides.
  ///
  /// Returns a [Widget] that can be added to the actions list.
  static Widget createAppBarActionButton({
    required String icon,
    required VoidCallback onPressed,
    Color? iconColor,
    Color? backgroundColor,
    double? iconSize,
    double? buttonSize,
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    final effectiveIconColor = iconColor ?? DSColorUsages.text.white;
    final effectiveBackgroundColor =
        backgroundColor ?? DSColorUsages.background.overlay.withOpacity(0.1);
    final effectiveIconSize = iconSize ?? DSIconSizes.size24;
    final effectiveMargin = margin ?? const EdgeInsets.all(10);
    final effectivePadding = padding ?? const EdgeInsets.all(6);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: effectiveMargin,
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: SizedBox(
          height: effectiveIconSize,
          width: effectiveIconSize,
          child: FittedBox(
            child: DSImageView(
              source: icon,
              height: effectiveIconSize,
              width: effectiveIconSize,
              fit: BoxFit.fitHeight,
              color: effectiveIconColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<DSBasicBrandScreenForm> createState() => _DSBasicBrandScreenFormState();
}

class _DSBasicBrandScreenFormState extends DSStateBase<DSBasicBrandScreenForm> {
  late DSBasicBrandScreenFormTheme componentTheme = theme
      .extension<DSBasicBrandScreenFormThemeExtension>()!
      .dSBasicBrandScreenFormTheme;

  /// Gets the theme configuration with widget-specific overrides.
  ///
  /// Applies widget parameters over theme defaults, with fallbacks to system defaults.
  DSBasicBrandScreenFormTheme get screenTheme => componentTheme.copyWith(
        // Header image: defaults to false
        showHeaderImage: widget.showHeaderImage ?? false,

        // Back button: defaults to true
        showBackButton: widget.showBackButton ?? true,

        // Border radius: defaults to false
        hasBottomBorderRadius: widget.hasBottomBorderRadius ?? false,

        // Border radius value: defaults to 12.0
        borderRadius: widget.borderRadius ?? 12.0,

        // Center title: defaults to true
        centerTitle: widget.centerTitle ?? true,

        // App bar divider: defaults to false
        showAppbarDivider: widget.showAppbarDivider ?? false,

        // Force center title: defaults to false
        forceCenterTitle: widget.forceCenterTitle ?? false,

        // App bar color: defaults to brand primary
        appbarColor:
            widget.appbarColor ?? DSColorUsages.background.brandPrimary,

        // App bar foreground color: defaults to white
        appbarForegroundColor:
            widget.appbarForegroundColor ?? DSColorUsages.text.white,

        // Title max lines: defaults to 1
        titleMaxLines: widget.titleMaxLines ?? 1,

        // Title style: widget -> theme -> system default
        titleStyle: widget.titleStyle ??
            componentTheme.titleStyle ??
            textTheme.lg?.semibold.copyWithColor(DSColorUsages.text.white),

        // Description style: widget -> theme -> system default
        desStyle: widget.desStyle ??
            componentTheme.desStyle ??
            textTheme.base?.medium.copyWithColor(DSColorUsages.text.white),

        // Background color: widget -> theme -> system default
        backgroundColor: widget.bgColor ?? DSColorUsages.background.secondary,
      );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateStatusBar();
  }

  /// Updates the status bar style based on header image setting.
  ///
  /// Sets dark status bar when [showHeaderImage] is true,
  /// light status bar otherwise.
  void _updateStatusBar() {
    if (screenTheme.showHeaderImage) {
      setDarkStatusBar();
    } else {
      setLightStatusBar();
    }
  }

  /// Determines whether the title should be centered.
  ///
  /// Returns true if:
  /// - [forceCenterTitle] is true, OR
  /// - [centerTitle] is true AND actions <= 1 AND no description
  bool get isCenterTitle =>
      screenTheme.forceCenterTitle ||
      (screenTheme.centerTitle &&
          widget.actions.length <= 1 &&
          widget.description?.isNotEmpty != true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: GestureDetector(
        onTap: hideKeyBoard,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Material(
                color: screenTheme.backgroundColor ??
                    DSColorUsages.background.secondary,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: widget.child ?? const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the app bar widget with title, description, back button, and actions.
  ///
  /// The app bar includes:
  /// - Status bar padding
  /// - Back button (if enabled)
  /// - Title and description
  /// - Action buttons
  /// - Optional extensions widget
  Widget _buildAppBar() {
    final appbarColor =
        screenTheme.appbarColor ?? DSColorUsages.background.brandPrimary;
    final appbarForegroundColor =
        screenTheme.appbarForegroundColor ?? DSColorUsages.text.white;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:
            screenTheme.hasBottomBorderRadius.let((hasBottomBorderRadius) {
          if (hasBottomBorderRadius == true) {
            return BorderRadius.only(
              bottomLeft: Radius.circular(screenTheme.borderRadius),
              bottomRight: Radius.circular(screenTheme.borderRadius),
            );
          }
          return BorderRadius.zero;
        }),
        image: screenTheme.showHeaderImage.let((image) {
          if (image == true) {
            // Note: You'll need to add header image asset to your assets
            // return DecorationImage(
            //   image: AssetImage('path_to_header_image'),
            //   fit: BoxFit.cover,
            //   alignment: Alignment.bottomCenter,
            // );
            return null;
          }
          return null;
        }),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.01, 0.01],
          colors: [
            screenTheme.showAppbarDivider ? Colors.black12 : appbarColor,
            appbarColor,
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: max(
              MediaQuery.of(context).padding.top,
              24,
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (screenTheme.showBackButton) ...[
                    widget.backButton ??
                        DSBasicBrandScreenForm.createAppBarActionButton(
                          icon: DSAssets.vuesax.arrowLeft2Linear,
                          onPressed: widget.onBack ??
                              () {
                                context.pop();
                              },
                        ),
                  ] else ...[
                    const SizedBox(width: 56),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 56),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.title ?? '',
                              style: screenTheme.titleStyle?.copyWith(
                                color: appbarForegroundColor,
                              ),
                              textAlign: isCenterTitle
                                  ? TextAlign.center
                                  : TextAlign.start,
                              maxLines: screenTheme.titleMaxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        if (widget.description?.isNotEmpty == true) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.description!,
                            style: screenTheme.desStyle?.copyWith(
                              color: appbarForegroundColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 56),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...widget.actions,
                ],
              ),
            ],
          ),
          if (widget.extentions != null) ...[
            widget.extentions!,
          ],
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
