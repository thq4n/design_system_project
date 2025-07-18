import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/icons/size_constants.dart';
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
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry prefixIconPadding;
  final EdgeInsetsGeometry suffixIconPadding;
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
    this.contentPadding,
    this.suffixIconPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.prefixIconPadding = const EdgeInsets.symmetric(horizontal: 8),
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
  }) : super(key: key);

  @override
  State<DSInput> createState() => _DSInputState();
}

class _DSInputState extends State<DSInput> {
  bool showPrefixIcon = true;
  DSInputController? _controller;

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
    final themeData = context.theme;
    if (widget.justShowPrefixIconWhenEmpty) {
      showPrefixIcon = _controller?.text.isEmpty == true;
    }
    return ValueListenableBuilder<InputContainerProperties>(
      valueListenable: _controller!,
      builder: (ctx, value, w) {
        Widget body;
        final textField = ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: widget.borderRadius,
          child: TextField(
            textAlign: widget.textAlign,
            focusNode: value.focusNode,
            readOnly: widget.readOnly || !widget.enable,
            controller: value.tdController,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              filled: true,
              hintText: widget.hint,
              hintStyle: widget.hintStyle ?? textTheme.xs,
              errorText: value.validation,
              errorStyle: textTheme.sm,
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
              fillColor: widget.enable ? widget.fillColor : null,
              counterStyle: textTheme.xs,
              focusedBorder: widget.enable
                  ? widget.focusedBorderSide?.let(
                      (it) => OutlineInputBorder(
                        borderSide: it ?? BorderSide(color: Colors.grey[300]!),
                        borderRadius: widget.borderRadius,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: widget.borderRadius,
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
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
            onEditingComplete: () =>
                widget.onEditingComplete?.call(_controller),
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
          ),
        );
        if (widget.title?.isNotEmpty == true) {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTitleWidget(
                title: widget.title ?? '',
                required: widget.required,
                style: widget.titleStyle,
              ),
              const SizedBox(height: 8),
              textField,
            ],
          );
        } else {
          body = textField;
        }
        final inputDecorationTheme = themeData.inputDecorationTheme;
        return Theme(
          data: themeData.copyWith(
            primaryColor: themeData.colorScheme.secondary,
            primaryColorDark: themeData.colorScheme.secondary,
            inputDecorationTheme: InputDecorationTheme(
              border: !widget.showBorder
                  ? InputBorder.none
                  : inputDecorationTheme.border.let((it) {
                      if (it is OutlineInputBorder) {
                        return it.copyWith(
                          borderSide: widget.borderSide,
                          borderRadius: widget.borderRadius,
                        );
                      }
                      return it?.copyWith(
                        borderSide: widget.borderSide,
                      );
                    }),
              enabledBorder: !widget.showBorder
                  ? InputBorder.none
                  : inputDecorationTheme.enabledBorder.let((it) {
                      if (it is OutlineInputBorder) {
                        return it.copyWith(
                          borderSide: widget.borderSide,
                          borderRadius: widget.borderRadius,
                        );
                      }
                      return it?.copyWith(
                        borderSide: widget.borderSide,
                      );
                    }),
              focusedBorder: !widget.showBorder
                  ? InputBorder.none
                  : inputDecorationTheme.focusedBorder.let((it) {
                      if (it is OutlineInputBorder) {
                        return it.copyWith(
                          borderSide: widget.borderSide,
                          borderRadius: widget.borderRadius,
                        );
                      }
                      return it?.copyWith(
                        borderSide: widget.borderSide,
                      );
                    }),
              contentPadding: widget.contentPadding ??
                  themeData.inputDecorationTheme.contentPadding,
            ),
          ),
          child: body,
        );
      },
    );
  }

  Widget? _getSuffixIcon() {
    final padding = widget.suffixIconPadding;
    if (widget.isPassword) {
      final icon = _getPasswordIcon();
      return InkWell(
        onTap: _controller?.showOrHidePass,
        child: Padding(
          padding: padding,
          child: icon,
        ),
      );
    }
    if (widget.withClearButton && widget.maxLines == 1 && !widget.readOnly) {
      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller!.value.tdController,
        builder: (context, value, child) {
          if (value.text.isEmpty && widget.suffixIcon != null) {
            return Padding(
              padding: padding,
              child: widget.suffixIcon,
            );
          }
          if (!widget.enable || widget.readOnly) {
            return const SizedBox();
          }
          if (value.text.isNotEmpty != true) {
            if (widget.suffixIcon != null) {
              return Padding(
                padding: padding,
                child: widget.suffixIcon,
              );
            }
            return const SizedBox();
          }
          return InkWell(
            onTap: () {
              _controller!.clear();
              _showPrefixFilterFn(_controller!.text);
              widget.onTextChanged?.call(_controller!.text, _controller);
              widget.onClear?.call(_controller);
            },
            child: Padding(
              padding: padding,
              child: ImageView(
                source: DSAssets.vuesax.a24SupportBold,
                width: DSSystemIconSizes.size24,
              ),
            ),
          );
        },
      );
    }
    if (widget.suffixIcon != null) {
      return Padding(
        padding: padding,
        child: widget.suffixIcon,
      );
    }
    return null;
  }

  Widget _getPasswordIcon() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Icon(
        _controller?.isShowPass == true
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        size: widget.suffixIconSize,
        color: Colors.grey,
      ),
    );
  }

  Widget? _getPrefixIcon() {
    final padding = widget.prefixIconPadding;
    if (!showPrefixIcon || widget.prefixIcon == null) {
      return null;
    }
    return AvailabilityWidget(
      enable: widget.enable,
      child: Padding(
        padding: padding,
        child: widget.prefixIcon,
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
