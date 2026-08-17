import 'package:flutter/material.dart';

import '../../design_system_project.dart';

class DSInputValue extends StatelessWidget {
  final String? value;
  final String? hint;
  final String? title;
  final TextStyle? titleStyle;
  final bool required;
  final bool enable;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final String? errorText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final int maxLines;
  final TextAlign textAlign;
  final bool? isDense;
  final double prefixIconSize;
  final double suffixIconSize;

  const DSInputValue({
    super.key,
    this.value,
    this.hint,
    this.title,
    this.titleStyle,
    this.required = false,
    this.enable = true,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.errorText,
    this.textStyle,
    this.hintStyle,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.isDense,
    this.prefixIconSize = 16.0,
    this.suffixIconSize = 16.0,
  });

  bool get _hasValue => value != null && value!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AvailabilityWidget(
      enable: enable,
      disabledOpacity: 1,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: enable ? onTap : null,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: InputDecorator(
            isEmpty: !_hasValue,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              isDense: isDense,
              filled: true,
              fillColor: enable
                  ? DSColorUsages.background.primary
                  : DSColorUsages.background.disable,
              enabled: enable,
              hintText: hint,
              hintMaxLines: 1,
              hintStyle: hintStyle,
              errorMaxLines: 2,
              error: errorText != null
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
                            text: errorText,
                            style: textTheme.sm?.regular.copyWith(
                              color: DSColorUsages.text.error,
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
              label: title != null
                  ? RichText(
                      text: TextSpan(
                        text: title,
                        style: enable
                            ? (titleStyle ??
                                textTheme.sm?.regular.copyWith(
                                  color: DSColorUsages.text.secondary,
                                ))
                            : (titleStyle ?? textTheme.sm?.regular)?.copyWith(
                                color: DSColorUsages.text.disable,
                              ),
                        children: [
                          if (required)
                            TextSpan(
                              text: '*',
                              style: textTheme.sm?.regular.copyWith(
                                color: enable
                                    ? DSColorUsages.text.error
                                    : DSColorUsages.text.disable,
                              ),
                            ),
                        ],
                      ),
                    )
                  : null,
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 4),
                      child: AvailabilityWidget(
                        enable: enable,
                        child: prefixIcon!,
                      ),
                    )
                  : null,
              prefixIconConstraints: BoxConstraints(
                minHeight: prefixIconSize,
                minWidth: prefixIconSize,
              ),
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16, left: 4),
                      child: AvailabilityWidget(
                        enable: enable,
                        child: SizedBox(
                          width: DSIconSizes.size24,
                          height: DSIconSizes.size24,
                          child: suffixIcon,
                        ),
                      ),
                    )
                  : null,
              suffixIconConstraints: BoxConstraints(
                minHeight: suffixIconSize < DSIconSizes.size24
                    ? DSIconSizes.size24
                    : suffixIconSize,
                minWidth: suffixIconSize,
              ),
            ),
            child: Text(
              _hasValue ? value! : '',
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: textAlign,
              style: _resolveTextStyle(textTheme),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle? _resolveTextStyle(DSTextTheme textTheme) {
    if (enable) {
      return textStyle ?? textTheme.base;
    }
    return textStyle ??
        textTheme.base?.copyWith(
          color: DSColorUsages.text.tertiary,
        );
  }
}
