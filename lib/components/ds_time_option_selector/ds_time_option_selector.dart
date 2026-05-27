import 'package:flutter/material.dart';

import '../../design_system_project.dart';

class DSTimeOptionSelector extends StatefulWidget {
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
  State<DSTimeOptionSelector> createState() => _DSTimeOptionSelectorState();
}

class _DSTimeOptionSelectorState extends State<DSTimeOptionSelector> {
  late final DSInputController _dsInputController;

  @override
  void initState() {
    super.initState();
    _dsInputController = DSInputController();
  }

  @override
  void dispose() {
    _dsInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.options.isEmpty) {
      return const SizedBox.shrink();
    }

    final themeExtension =
        Theme.of(context).extension<DSTimeOptionSelectorThemeExtension>();
    final componentTheme = themeExtension != null
        ? themeExtension.getDSTimeOptionSelectorTheme(context)
        : DSTimeOptionSelectorTheme.fromContext(context);

    final effectiveLabelBuilder =
        widget.labelBuilder ?? (value) => '$value phút';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.title != null) ...[
          Text.rich(
            TextSpan(
              text: widget.title,
              style: componentTheme.textStyle?.copyWithColor(
                componentTheme.titleColor,
              ),
              children: [
                if (widget.required)
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
          children: [
            ...List.generate((widget.options.length / widget.columns).ceil(),
                (rowIndex) {
              final startIndex = rowIndex * widget.columns;
              final endIndex =
                  (startIndex + widget.columns).clamp(0, widget.options.length);
              final rowOptions = widget.options.sublist(startIndex, endIndex);

              return Padding(
                padding: EdgeInsets.only(
                  bottom: rowIndex ==
                          (widget.options.length / widget.columns).ceil() - 1
                      ? 0
                      : componentTheme.mainAxisSpacing,
                ),
                child: Row(
                  children: List.generate(widget.columns, (columnIndex) {
                    final hasValue = columnIndex < rowOptions.length;

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: columnIndex == widget.columns - 1
                              ? 0
                              : componentTheme.crossAxisSpacing,
                        ),
                        child: hasValue
                            ? ValueListenableBuilder(
                                valueListenable:
                                    _dsInputController.value.tdController,
                                builder: (context, value, child) {
                                  return _DSTimeOptionTile(
                                    label: effectiveLabelBuilder(
                                      rowOptions[columnIndex],
                                    ),
                                    iconSource: widget.iconSource,
                                    isSelected: widget.selectedValue ==
                                            rowOptions[columnIndex] &&
                                        _dsInputController.text.isEmpty,
                                    theme: componentTheme,
                                    onTap: () {
                                      _dsInputController.clear();
                                      widget.onChanged(rowOptions[columnIndex]);
                                    },
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                    );
                  }),
                ),
              );
            }),
            const SizedBox(height: 8),
            DSInput(
              key: const Key(
                'ds_time_option_selector_input',
              ),
              controller: _dsInputController,
              title: 'Nhập số phút khác',
              hint: 'Nhập số phút khác',
              keyboardType: TextInputType.number,
              inputFormatters: [IntegerTextInputFormatter()],
              textInputAction: TextInputAction.next,
              onTap: (controller) async {
                widget.onChanged(0);
              },
              onTextChanged: (text, controller) {
                widget.onChanged(text.intNumber ?? 0);
              },
            ),
          ],
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
