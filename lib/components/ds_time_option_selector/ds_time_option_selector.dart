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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: componentTheme.crossAxisSpacing,
            mainAxisSpacing: componentTheme.mainAxisSpacing,
            childAspectRatio: componentTheme.childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final value = options[index];
            final isSelected = selectedValue == value;
            return _DSTimeOptionTile(
              label: effectiveLabelBuilder(value),
              iconSource: iconSource,
              isSelected: isSelected,
              theme: componentTheme,
              onTap: () => onChanged(value),
            );
          },
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
