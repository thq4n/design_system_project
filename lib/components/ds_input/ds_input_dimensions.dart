import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../design_system_project.dart';

part 'controller/ds_input_dimensions.controller.dart';

enum DSInputDimensionCellPosition {
  first,
  middle,
  lastInput,
}

class DSInputDimensions extends StatefulWidget {
  final DSInputDimensionsController? controller;
  final String? title;
  final TextStyle? titleStyle;
  final bool required;
  final bool enable;
  final Color fillColor;
  final BorderRadius borderRadius;
  final List<String> fieldLabels;
  final String? lengthHint;
  final String? widthHint;
  final String? heightHint;
  final String? initialLength;
  final String? initialWidth;
  final String? initialHeight;
  final Widget? suffixIcon;
  final String? measureUnit;
  final double? suffixCellWidth;
  final double suffixIconSize;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool? isDense;
  final void Function(DSInputDimensionsController? controller)? onChanged;
  final void Function(DSInputDimensionsController? controller)?
      onEditingComplete;
  final bool isAutoUnfocus;
  final void Function(DSInputDimensionsController? controller)? onTapOutside;

  const DSInputDimensions({
    Key? key,
    this.controller,
    this.title,
    this.titleStyle,
    this.required = false,
    this.enable = true,
    this.fillColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.fieldLabels = const ['Dài', 'Rộng', 'Cao'],
    this.lengthHint,
    this.widthHint,
    this.heightHint,
    this.initialLength,
    this.initialWidth,
    this.initialHeight,
    this.suffixIcon,
    this.measureUnit,
    this.suffixCellWidth,
    this.suffixIconSize = 24,
    this.keyboardType,
    this.inputFormatters,
    this.textStyle,
    this.hintStyle,
    this.isDense,
    this.onChanged,
    this.onEditingComplete,
    this.isAutoUnfocus = true,
    this.onTapOutside,
  }) : super(key: key);

  @override
  State<DSInputDimensions> createState() => _DSInputDimensionsState();
}

class _DSInputDimensionsState extends State<DSInputDimensions> {
  DSInputDimensionsController? _controller;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();
    _setupController();
  }

  @override
  void didUpdateWidget(covariant DSInputDimensions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (_ownsController) {
        _controller?.dispose();
        _ownsController = false;
      }
      _controller = null;
      _setupController();
    }
  }

  void _setupController() {
    _controller ??= widget.controller ?? DSInputDimensionsController();
    _ownsController = widget.controller == null;

    final v = _controller!.value;
    if (widget.initialLength != null && v.lengthController.text.isEmpty) {
      v.lengthController.text = widget.initialLength!;
    }
    if (widget.initialWidth != null && v.widthController.text.isEmpty) {
      v.widthController.text = widget.initialWidth!;
    }
    if (widget.initialHeight != null && v.heightController.text.isEmpty) {
      v.heightController.text = widget.initialHeight!;
    }
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller?.dispose();
    }
    super.dispose();
  }

  Color _borderColorForCell({
    required bool hasError,
  }) {
    if (hasError) {
      return DSColorUsages.border.error;
    }
    return DSColorUsages.border.primary;
  }

  Color _suffixBorderColor(bool hasError) {
    if (hasError) {
      return DSColorUsages.border.error;
    }
    return DSColorUsages.border.primary;
  }

  static Border _borderForInputCell({
    required DSInputDimensionCellPosition position,
    required Color color,
  }) {
    final side = BorderSide(color: color, width: 1);
    return Border(
      left: position == DSInputDimensionCellPosition.first
          ? side
          : BorderSide.none,
      top: side,
      bottom: side,
      right: side,
    );
  }

  static Border _borderForSuffix(Color color) {
    final side = BorderSide(color: color, width: 1);
    return Border(
      top: side,
      bottom: side,
      right: side,
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = widget.fieldLabels;
    if (labels.length != 3) {
      throw ArgumentError('fieldLabels must contain exactly 3 entries');
    }

    return AvailabilityWidget(
      enable: widget.enable,
      child: ValueListenableBuilder<DimensionsInputProperties>(
        valueListenable: _controller!,
        builder: (context, value, _) {
          final hasError = value.validation != null;
          final radiusValue = widget.borderRadius.topLeft.x;

          Widget buildInputCell({
            required DSInputDimensionCellPosition position,
            required TextEditingController textController,
            required FocusNode focusNode,
            required String label,
            required String? hint,
            required TextInputAction action,
            required VoidCallback? onFieldSubmitted,
          }) {
            final borderColor = _borderColorForCell(
              hasError: hasError,
            );

            final BorderRadius geometry;
            switch (position) {
              case DSInputDimensionCellPosition.first:
                geometry = BorderRadius.only(
                  topLeft: Radius.circular(radiusValue),
                  bottomLeft: Radius.circular(radiusValue),
                );
                break;
              case DSInputDimensionCellPosition.middle:
              case DSInputDimensionCellPosition.lastInput:
                geometry = BorderRadius.zero;
            }

            final inputTheme = Theme.of(context).inputDecorationTheme;
            final fieldStyle =
                widget.textStyle ?? context.textTheme.base?.medium;
            final tertiaryStyle = widget.hintStyle ??
                inputTheme.hintStyle ??
                context.textTheme.base?.medium
                    .copyWithColor(DSColorUsages.text.tertiary);

            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: widget.fillColor,
                  borderRadius: geometry,
                  border: _borderForInputCell(
                    position: position,
                    color: borderColor,
                  ),
                ),
                child: TextField(
                  focusNode: focusNode,
                  controller: textController,
                  enabled: widget.enable,
                  readOnly: !widget.enable,
                  keyboardType: widget.keyboardType ??
                      const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                  inputFormatters: widget.inputFormatters,
                  textInputAction: action,
                  style: fieldStyle,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    label: RichText(
                      text: TextSpan(
                        text: label,
                        style: context.textTheme.sm?.regular
                            .copyWithColor(DSColorUsages.text.secondary),
                      ),
                    ),
                    hintText: hint,
                    hintStyle: tertiaryStyle,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: widget.fillColor,
                    contentPadding: inputTheme.contentPadding ??
                        const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                    isDense: widget.isDense,
                    counterStyle: context.textTheme.xs,
                  ),
                  onChanged: (_) {
                    if (value.validation != null) {
                      _controller?.resetValidation();
                    }
                    widget.onChanged?.call(_controller);
                  },
                  onEditingComplete: () {
                    widget.onEditingComplete?.call(_controller);
                    onFieldSubmitted?.call();
                  },
                  onTapOutside: (_) {
                    if (widget.isAutoUnfocus) {
                      _controller?.unfocus();
                    }
                    widget.onTapOutside?.call(_controller);
                  },
                ),
              ),
            );
          }

          final suffixBorder = _suffixBorderColor(hasError);
          final suffixRadius = BorderRadius.only(
            topRight: Radius.circular(radiusValue),
            bottomRight: Radius.circular(radiusValue),
          );

          Widget suffixInner;
          if (widget.suffixIcon != null) {
            suffixInner = SizedBox(
              width: widget.suffixIconSize,
              height: widget.suffixIconSize,
              child: AvailabilityWidget(
                enable: widget.enable,
                child: widget.suffixIcon!,
              ),
            );
          } else if (widget.measureUnit != null) {
            suffixInner = Text(
              widget.measureUnit!,
              style: context.textTheme.base?.medium
                  .copyWithColor(DSColorUsages.text.tertiary),
            );
          } else {
            suffixInner = const SizedBox.shrink();
          }

          final suffixBody = Padding(
            padding: const EdgeInsets.only(right: 16, left: 4),
            child: Center(child: suffixInner),
          );

          final suffixWidth = widget.suffixCellWidth ?? 56.0;
          final suffixCell = SizedBox(
            width: suffixWidth,
            child: suffixBody,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: RichText(
                    text: TextSpan(
                      text: widget.title,
                      style: widget.titleStyle ??
                          context.textTheme.sm?.regular.copyWith(
                            color: DSColorUsages.text.secondary,
                          ),
                      children: [
                        if (widget.required)
                          TextSpan(
                            text: '*',
                            style: context.textTheme.sm?.regular.copyWith(
                              color: DSColorUsages.text.error,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInputCell(
                    position: DSInputDimensionCellPosition.first,
                    textController: value.lengthController,
                    focusNode: value.lengthFocus,
                    label: labels[0],
                    hint: widget.lengthHint,
                    action: TextInputAction.next,
                    onFieldSubmitted: () => value.widthFocus.requestFocus(),
                  ),
                  buildInputCell(
                    position: DSInputDimensionCellPosition.middle,
                    textController: value.widthController,
                    focusNode: value.widthFocus,
                    label: labels[1],
                    hint: widget.widthHint,
                    action: TextInputAction.next,
                    onFieldSubmitted: () => value.heightFocus.requestFocus(),
                  ),
                  buildInputCell(
                    position: DSInputDimensionCellPosition.lastInput,
                    textController: value.heightController,
                    focusNode: value.heightFocus,
                    label: labels[2],
                    hint: widget.heightHint,
                    action: TextInputAction.done,
                    onFieldSubmitted: null,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: widget.fillColor,
                      borderRadius: suffixRadius,
                      border: _borderForSuffix(suffixBorder),
                    ),
                    alignment: Alignment.center,
                    child: suffixCell,
                  ),
                ],
              ),
              if (value.validation != null) ...[
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.warning_rounded,
                          color: DSColorUsages.text.error,
                          size: DSIconSizes.size16,
                        ),
                        alignment: PlaceholderAlignment.middle,
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 4),
                        alignment: PlaceholderAlignment.middle,
                      ),
                      TextSpan(
                        text: value.validation ?? '',
                        style: context.textTheme.sm?.regular.copyWith(
                          color: DSColorUsages.text.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
