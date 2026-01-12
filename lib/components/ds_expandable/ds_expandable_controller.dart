import 'package:flutter/foundation.dart';

/// Controller for managing the expansion state of [DSExpandable] widget.
///
/// This controller allows you to programmatically control the expand/collapse
/// state of an expandable widget from outside the widget itself.
///
/// Example usage:
/// ```dart
/// final controller = DSExpandableController(initiallyExpanded: true);
///
/// DSExpandable(
///   controller: controller,
///   title: 'My Title',
///   body: Text('Content'),
/// )
///
/// // Later, programmatically control:
/// controller.expand();
/// controller.collapse();
/// controller.toggle();
/// ```
class DSExpandableController extends ValueNotifier<bool> {
  /// Callback called when expansion state changes
  final ValueChanged<bool>? onExpansionChanged;

  /// Creates a controller for [DSExpandable].
  ///
  /// [initiallyExpanded] determines the initial expansion state.
  /// [onExpansionChanged] is called whenever the expansion state changes.
  DSExpandableController({
    bool initiallyExpanded = true,
    this.onExpansionChanged,
  }) : super(initiallyExpanded);

  /// Whether the expandable is currently expanded
  bool get isExpanded => value;

  /// Expand the expandable widget
  void expand() {
    if (!value) {
      value = true;
      onExpansionChanged?.call(value);
    }
  }

  /// Collapse the expandable widget
  void collapse() {
    if (value) {
      value = false;
      onExpansionChanged?.call(value);
    }
  }

  /// Toggle the expansion state
  void toggle() {
    value = !value;
    onExpansionChanged?.call(value);
  }
}
