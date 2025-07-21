import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/icons/size_constants.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../theme/ds_theme.dart';
import '../../utils/object_utils.dart';

import '../../widgets/widgets.dart';
import '../ds_image_view/ds_image_view.dart';

part 'controller/ds_input.controller.dart';

class DSInput extends StatefulWidget {
  final DSInputController? controller;
  final String? hint;
  final bool isPassword;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final void Function(DSInputController? controller)? onTap;
  final void Function(String text, DSInputController? controller)?
      onTextChanged;
  final void Function(String text, DSInputController? controller)? onSubmitted;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final String? title;
  final TextStyle? titleStyle;
  final bool required;
  final Color fillColor;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;
  final TextAlign textAlign;
  final int? maxLength;
  final bool showBorder;
  final TextInputAction? textInputAction;
  final void Function(DSInputController? controller)? onEditingComplete;
  final double prefixIconSize;
  final double suffixIconSize;
  final BorderRadius borderRadius;
  final bool justShowPrefixIconWhenEmpty;
  final bool withClearButton;
  final void Function(DSInputController? controller)? onClear;
  final bool? isDense;
  final void Function(DSInputController? controller)? onTapOutSide;
  final bool isAutoUnfocus;
  final String? initialValue;
  final List<String>? autofillHints;

  const DSInput({
    Key? key,
    this.controller,
    this.hint,
    this.isPassword = false,
    this.readOnly = false,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.onTextChanged,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.onSubmitted,
    this.onClear,
    this.enable = true,
    this.title,
    this.titleStyle,
    this.required = false,
    this.fillColor = Colors.white,
    this.prefixIcon,
    this.hintStyle,
    this.textStyle,
    this.borderSide,
    this.focusedBorderSide,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.showBorder = true,
    this.onEditingComplete,
    this.textInputAction,
    this.prefixIconSize = 16.0,
    this.suffixIconSize = 16.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(6.0)),
    this.justShowPrefixIconWhenEmpty = false,
    this.withClearButton = true,
    this.isDense,
    this.onTapOutSide,
    this.isAutoUnfocus = true,
    this.initialValue,
    this.autofillHints,
  }) : super(key: key);

  @override
  State<DSInput> createState() => _DSInputState();
}

class _DSInputState extends State<DSInput> {
  bool showPrefixIcon = true;
  DSInputController? _controller;
  ValueNotifier<bool> isFocused = ValueNotifier(false);

  late final theme = Theme.of(context);
  late final componentTheme =
      theme.extension<DSInputThemeExtension>()!.dSInputTheme;

  @override
  void initState() {
    _setupController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DSInput oldWidget) {
    _setupController();
    super.didUpdateWidget(oldWidget);
  }

  void _setupController() {
    _controller ??= widget.controller ?? DSInputController();

    // Set initial value nếu có
    if (widget.initialValue != null &&
        (_controller?.text.isEmpty == true || widget.controller == null)) {
      _controller?.text = widget.initialValue ?? '';
    }

    _controller?.value.focusNode.addListener(() {
      isFocused.value = _controller?.value.focusNode.hasFocus ?? false;
    });
  }

  @override
  void dispose() {
    // Chỉ dispose controller nếu nó được khởi tạo bên trong widget
    if (widget.controller == null) {
      _controller?.dispose();
    }
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.justShowPrefixIconWhenEmpty) {
      showPrefixIcon = _controller?.text.isEmpty == true;
    }
    return ValueListenableBuilder<InputContainerProperties>(
      valueListenable: _controller!,
      builder: (ctx, value, w) {
        final textField = TextField(
          textAlign: widget.textAlign,
          focusNode: value.focusNode,
          readOnly: widget.readOnly || !widget.enable,
          controller: value.tdController,
          maxLength: widget.maxLength,
          autofillHints: widget.autofillHints,
          decoration: InputDecoration(
            error: value.validation != null
                ? RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.warning_rounded,
                            color: DSColorUsages.text.error,
                            size: DSIconSizes.size16,
                          ),
                          alignment: PlaceholderAlignment.bottom,
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 4),
                          alignment: PlaceholderAlignment.bottom,
                        ),
                        TextSpan(
                          text: value.validation ?? '',
                          style: textTheme.sm?.regular
                              .copyWith(color: DSColorUsages.text.error),
                        ),
                      ],
                    ),
                  )
                : null,
            label: RichText(
              text: TextSpan(
                text: widget.title ?? '',
                style: widget.titleStyle ??
                    textTheme.sm?.regular.copyWith(
                      color: DSColorUsages.text.secondary,
                    ),
                children: [
                  TextSpan(
                    text: '*',
                    style: textTheme.sm?.regular
                        .copyWith(color: DSColorUsages.text.error),
                  ),
                ],
              ),
            ),
            hintText: widget.hint,
            errorMaxLines: 2,
            suffixIcon: _getSuffixIcon()?.let(
              (it) => it != null
                  ? AvailabilityWidget(
                      enable: widget.enable,
                      child: it,
                    )
                  : null,
            ),
            suffixIconConstraints: BoxConstraints(
              minHeight: widget.suffixIconSize,
              minWidth: widget.suffixIconSize,
            ),
            prefixIcon: _getPrefixIcon(),
            prefixIconConstraints: BoxConstraints(
              minHeight: widget.prefixIconSize,
              minWidth: widget.prefixIconSize,
            ),
            isDense: widget.isDense,
            counterStyle: textTheme.xs,
          ),
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          style: widget.textStyle ??
              (widget.enable ? textTheme.base : textTheme.xs),
          obscureText: widget.isPassword && _controller?.isShowPass != true,
          onChanged: (text) {
            _showPrefixFilterFn(text);

            if (value.validation != null) {
              _controller?.resetValidation();
            }
            widget.onTextChanged?.call(text, _controller);
          },
          onEditingComplete: () => widget.onEditingComplete?.call(_controller),
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          inputFormatters: widget.inputFormatters,
          onTap: () => widget.enable ? widget.onTap?.call(_controller) : null,
          onSubmitted: (String text) =>
              widget.onSubmitted?.call(text, _controller),
          textInputAction: widget.textInputAction,
          onTapOutside: (event) {
            if (widget.isAutoUnfocus) {
              _controller?.unfocus();
            }
            widget.onTapOutSide?.call(_controller);
          },
        );

        return textField;
      },
    );
  }

  Widget? _getSuffixIcon() {
    Widget? result;

    if (widget.isPassword) {
      result = InkWell(
        onTap: _controller?.showOrHidePass,
        child: SizedBox(
          width: DSIconSizes.size24,
          height: DSIconSizes.size24,
          child: _getPasswordIcon(),
        ),
      );
    } else if (widget.withClearButton &&
        widget.maxLines == 1 &&
        !widget.readOnly) {
      result = ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller!.value.tdController,
        builder: (context, value, child) {
          if (!widget.enable || widget.readOnly) {
            return const SizedBox();
          } else if (value.text.isEmpty) {
            return widget.suffixIcon != null
                ? SizedBox(
                    width: DSIconSizes.size24,
                    height: DSIconSizes.size24,
                    child: widget.suffixIcon,
                  )
                : const SizedBox();
          } else if (widget.suffixIcon != null) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _controller!.clear();
                    _showPrefixFilterFn(_controller!.text);
                    widget.onTextChanged?.call(_controller!.text, _controller);
                    widget.onClear?.call(_controller);
                  },
                  child: SizedBox(
                    width: DSIconSizes.size24,
                    height: DSIconSizes.size24,
                    child: DSImageView(
                      source: DSAssets.vuesax.closeCircleLinear,
                      width: DSIconSizes.size24,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 1,
                  height: 23,
                  color: DSColorUsages.border.primary,
                ),
                SizedBox(
                  width: DSIconSizes.size24,
                  height: DSIconSizes.size24,
                  child: widget.suffixIcon,
                ),
              ],
            );
          } else {
            return InkWell(
              onTap: () {
                _controller!.clear();
                _showPrefixFilterFn(_controller!.text);
                widget.onTextChanged?.call(_controller!.text, _controller);
                widget.onClear?.call(_controller);
              },
              child: SizedBox(
                width: DSIconSizes.size24,
                height: DSIconSizes.size24,
                child: DSImageView(
                  source: DSAssets.vuesax.closeCircleLinear,
                  width: DSIconSizes.size24,
                ),
              ),
            );
          }
        },
      );
    } else if (widget.suffixIcon != null) {
      result = SizedBox(
        width: DSIconSizes.size24,
        height: DSIconSizes.size24,
        child: widget.suffixIcon,
      );
    } else {
      result = null;
    }

    if (result != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: result,
      );
    }
    return null;
  }

  Widget _getPasswordIcon() {
    return DSImageView(
      source: _controller?.isShowPass == true
          ? DSAssets.vuesax.eyeSlashLinear
          : DSAssets.vuesax.eyeLinear,
      width: DSIconSizes.size24,
    );
  }

  Widget? _getPrefixIcon() {
    if (!showPrefixIcon || widget.prefixIcon == null) {
      return null;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: AvailabilityWidget(
        enable: widget.enable,
        child: widget.prefixIcon!,
      ),
    );
  }

  void _showPrefixFilterFn(String text) {
    final isEmpty = text.isEmpty;
    if (widget.justShowPrefixIconWhenEmpty &&
        showPrefixIcon != isEmpty &&
        mounted) {
      setState(() {
        showPrefixIcon = isEmpty;
      });
    }
  }
}
