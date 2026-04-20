import 'package:flutter/material.dart';

import '../../design_system_project.dart';

class DSTimeOptionSelector extends StatelessWidget {
  const DSTimeOptionSelector({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.columns = 2,
    this.labelBuilder,
    this.iconSource,
    this.required = false,
    this.title,
  });

  final List<int> options;
  final int? selectedValue;
  final ValueChanged<int> onChanged;
  final int columns;
  final String Function(int value)? labelBuilder;
  final String? iconSource;
  final bool required;
  final String? title;

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    final themeExtension =
        Theme.of(context).extension<DSTimeOptionSelectorThemeExtension>();
    final componentTheme = themeExtension != null
        ? themeExtension.getDSTimeOptionSelectorTheme(context)
        : DSTimeOptionSelectorTheme.fromContext(context);

    final effectiveLabelBuilder = labelBuilder ?? (value) => '$value phút';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          Text.rich(
            TextSpan(
              text: title,
              style: componentTheme.textStyle?.copyWithColor(
                componentTheme.titleColor,
              ),
              children: [
                if (required)
                  TextSpan(
                    text: ' *',
                    style: componentTheme.textStyle?.copyWithColor(
                      componentTheme.requiredIndicatorColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
        Column(
          children:
              List.generate((options.length / columns).ceil(), (rowIndex) {
            final startIndex = rowIndex * columns;
            final endIndex = (startIndex + columns).clamp(0, options.length);
            final rowOptions = options.sublist(startIndex, endIndex);

            return Padding(
              padding: EdgeInsets.only(
                bottom: rowIndex == (options.length / columns).ceil() - 1
                    ? 0
                    : componentTheme.mainAxisSpacing,
              ),
              child: Row(
                children: List.generate(columns, (columnIndex) {
                  final hasValue = columnIndex < rowOptions.length;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: columnIndex == columns - 1
                            ? 0
                            : componentTheme.crossAxisSpacing,
                      ),
                      child: hasValue
                          ? _DSTimeOptionTile(
                              label: effectiveLabelBuilder(
                                rowOptions[columnIndex],
                              ),
                              iconSource: iconSource,
                              isSelected:
                                  selectedValue == rowOptions[columnIndex],
                              theme: componentTheme,
                              onTap: () => onChanged(rowOptions[columnIndex]),
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _DSTimeOptionTile extends StatelessWidget {
  const _DSTimeOptionTile({
    required this.label,
    required this.iconSource,
    required this.isSelected,
    required this.theme,
    required this.onTap,
  });

  final String label;
  final String? iconSource;
  final bool isSelected;
  final DSTimeOptionSelectorTheme theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: theme.selectionAnimationDuration,
        curve: theme.selectionAnimationCurve,
        padding: theme.tilePadding,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.selectedBackgroundColor
              : theme.unselectedBackgroundColor,
          borderRadius: theme.borderRadius.borderRadiusGeometry,
          border: Border.all(
            color: isSelected
                ? theme.selectedBorderColor
                : theme.unselectedBorderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconSource != null) ...[
              DSImageView(
                source: iconSource!,
                width: DSIconSizes.size20,
                height: DSIconSizes.size20,
                color: theme.iconColor,
              ),
              SizedBox(width: theme.iconLabelSpacing),
            ],
            Flexible(
              child: Text(
                label,
                style: theme.textStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
