import 'package:flutter/material.dart';
import '../design_system_project.dart';

class AppBottomModal<T> extends StatefulWidget {
  final String title;
  final EdgeInsetsGeometry? titlePadding;

  final Widget Function(
    T item,
    bool isSelected,
    ValueNotifier<T?>? selectedItemNotifier,
  )? itemBuilder;
  final Function(T? item)? onConfirm;
  final bool isShowDismissButton;
  final Function()? onDismiss;
  final String? applyText;
  final String? cancelText;
  final bool dismissWhenAction;
  final bool Function(T? selectedItem)? onDisableAction;
  final bool Function(T? selectedItem)? isChanged;
  final Widget? child;
  final ValueNotifier<T?>? selectedItemNotifier;
  final T? initialData;

  const AppBottomModal({
    super.key,
    required this.title,
    this.titlePadding,
    this.itemBuilder,
    this.onConfirm,
    required this.isShowDismissButton,
    this.onDismiss,
    this.applyText,
    this.cancelText,
    required this.dismissWhenAction,
    this.onDisableAction,
    this.isChanged,
    this.child,
    this.selectedItemNotifier,
    this.initialData,
  });

  @override
  State<AppBottomModal<T>> createState() => _AppBottomModalState<T>();
}

class _AppBottomModalState<T> extends State<AppBottomModal<T>> {
  late final ValueNotifier<T?> _selectedItemNotifier =
      (widget.selectedItemNotifier ?? ValueNotifier(null))
        ..value = widget.initialData;
  late final ValueNotifier<bool Function(T?)?> _onDisableActionNotifier;

  set selectedItem(T? item) {
    _selectedItemNotifier.value = item;
  }

  bool get isShowDismissButton => widget.isShowDismissButton;
  bool get isShowApplyButton => widget.onConfirm != null;

  bool get isShowActionButtons => isShowDismissButton && isShowApplyButton;

  @override
  void initState() {
    super.initState();

    _onDisableActionNotifier = ValueNotifier(
      widget.onDisableAction,
    );
  }

  @override
  void dispose() {
    _selectedItemNotifier.dispose();
    super.dispose();
  }

  void _onConfirm() {
    widget.onConfirm?.call(_selectedItemNotifier.value);
    if (widget.dismissWhenAction) {
      Navigator.of(context).pop();
    }
  }

  void _onDismiss() {
    widget.onDismiss?.call();
    if (widget.dismissWhenAction) {
      Navigator.of(context).pop();
    }
  }

  void _onClear() {
    _selectedItemNotifier.value = null;
  }

  bool _isNotChanged() {
    if (widget.onDisableAction != null) {
      return widget.onDisableAction!(_selectedItemNotifier.value);
    }
    return widget.isChanged?.call(_selectedItemNotifier.value) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.gray.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: colors.gray.shape200,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: widget.titlePadding ??
                      const EdgeInsets.fromLTRB(16, 5, 16, 15),
                  child: Text(
                    widget.title,
                    style: textTheme.lg?.semibold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _onDismiss,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.fromLTRB(
                    12,
                    2,
                    12,
                    12,
                  ),
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: FittedBox(
                      child: Icon(
                        Icons.close_rounded,
                        color: DSColorUsages.icon.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (widget.child != null) widget.child!,

          // Bottom button
          if (isShowActionButtons)
            FooterWidget(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: ValueListenableBuilder<bool Function(T?)?>(
                valueListenable: _onDisableActionNotifier,
                builder: (context, onDisabled, _) {
                  return ValueListenableBuilder<T?>(
                    valueListenable: _selectedItemNotifier,
                    builder: (context, selectedItem, child) {
                      return Row(
                        children: [
                          if (widget.isShowDismissButton) ...[
                            Expanded(
                              child: DSButton(
                                label: widget.cancelText ?? 'Bỏ chọn',
                                onPressed: _onClear,
                                variant: DSButtonVariants.tertiary,
                                isDisabled: selectedItem == null,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: DSButton(
                              label: widget.applyText ?? 'Áp dụng',
                              onPressed: _onConfirm,
                              variant: DSButtonVariants.primary,
                              isDisabled: _isNotChanged(),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
