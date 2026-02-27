import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../design_system_project.dart';

class MultipleFilterSelectionModal<T> extends StatefulWidget {
  final String title;
  final EdgeInsetsGeometry? titlePadding;
  final Future<List<T>> Function({
    String? searchTerm,
  })? onRefreshItems;
  final Future<List<T>> Function({
    String? searchTerm,
  })? onLoadMoreItems;
  final bool Function()? canLoadMore;
  final String Function(T item) getItemLabel;
  final String? hintSearch;
  final DSInputController? searchController;
  final List<T>? initialItems;
  final List<T>? initialSelectedItems;
  final Widget Function(
    T item,
    bool isSelected,
    ValueNotifier<List<T>>? selectedItemNotifier,
  )? itemBuilder;
  final Function(List<T> items)? onConfirm;
  final Function()? onDismiss;
  final String? applyText;
  final String? cancelText;
  final RefreshController? refreshController;
  final bool dismissWhenAction;
  final bool Function(List<T> selectedItem)? onDisableAction;

  const MultipleFilterSelectionModal({
    super.key,
    required this.title,
    this.titlePadding,
    this.onRefreshItems,
    this.onLoadMoreItems,
    this.canLoadMore,
    required this.getItemLabel,
    this.hintSearch,
    this.searchController,
    this.initialItems,
    this.refreshController,
    this.initialSelectedItems,
    this.itemBuilder,
    this.onConfirm,
    this.onDismiss,
    this.applyText,
    this.cancelText,
    required this.dismissWhenAction,
    this.onDisableAction,
  });

  @override
  State<MultipleFilterSelectionModal<T>> createState() =>
      _MultipleFilterSelectionModalState<T>();
}

class _MultipleFilterSelectionModalState<T>
    extends State<MultipleFilterSelectionModal<T>> {
  late final ValueNotifier<List<T>> _selectedItemsNotifier;
  late final ValueNotifier<List<T>> _itemsNotifier;
  String? _searchTerm;
  late Debouncer _debouncer;
  late final _refreshController =
      widget.refreshController ?? RefreshController(initialRefresh: true);

  bool get isHasFetchItems =>
      widget.onRefreshItems != null || widget.onLoadMoreItems != null;

  bool get isExpandedBody => isHasFetchItems;

  @override
  void initState() {
    super.initState();
    _selectedItemsNotifier =
        ValueNotifier(widget.initialSelectedItems?.toList() ?? []);
    _itemsNotifier = ValueNotifier(widget.initialItems ?? []);
    _debouncer = Debouncer<String>(const Duration(milliseconds: 500), (text) {
      _searchTerm = text;
      _onRefresh();
    });
  }

  @override
  void dispose() {
    if (widget.refreshController == null) {
      _refreshController.dispose();
    }
    _debouncer.cancel();
    _selectedItemsNotifier.dispose();
    _itemsNotifier.dispose();
    super.dispose();
  }

  void _onRefresh() {
    widget.onRefreshItems
        ?.call(
          searchTerm: _searchTerm,
        )
        .then(
          (items) => {
            _itemsNotifier.value = [],
            if (items.isNotEmpty == true) _itemsNotifier.value = [...items],
            _refreshController
              ..refreshCompleted()
              ..loadComplete(),
          },
        )
        .catchError((error) {
      _refreshController
        ..refreshFailed()
        ..loadFailed();

      return <Object>{};
    });
  }

  void _onLoadMore() {
    widget.onLoadMoreItems
        ?.call(
          searchTerm: _searchTerm,
        )
        .then(
          (items) => {
            if (items.isNotEmpty == true)
              _itemsNotifier.value = [..._itemsNotifier.value, ...items],
            _refreshController
              ..refreshCompleted()
              ..loadComplete(),
          },
        )
        .catchError((error) {
      _refreshController
        ..refreshFailed()
        ..loadFailed();

      return <Object>{};
    });
  }

  void _onConfirm() {
    widget.onConfirm?.call(_selectedItemsNotifier.value);
    if (widget.dismissWhenAction) {
      Navigator.of(context).pop();
    }
  }

  void _onToggleItem(T item) {
    final currentSelected = List<T>.from(_selectedItemsNotifier.value);
    final isSelected = currentSelected.contains(item);

    if (isSelected) {
      currentSelected.remove(item);
    } else {
      currentSelected.add(item);
    }

    _selectedItemsNotifier.value = currentSelected;
  }

  void _onDismiss() {
    widget.onDismiss?.call();
    if (widget.dismissWhenAction) {
      Navigator.of(context).pop();
    }
  }

  void _onClear() {
    _selectedItemsNotifier.value = [];
  }

  bool _isNotChanged() {
    return const DeepCollectionEquality.unordered().equals(
      _selectedItemsNotifier.value,
      widget.initialSelectedItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.gray.white,
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
              color: colors.gray.shade200,
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

          // Search bar
          if (isHasFetchItems) ...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colors.gray.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DSInput(
                controller: widget.searchController,
                hint: widget.hintSearch ??
                    'Tìm kiếm ${widget.title.toLowerCase()}',
                prefixIcon:
                    DSImageView(source: DSAssets.vuesax.searchNormal1Linear),
                onTextChanged: (text, _) {
                  _debouncer.value = text;
                },
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Items list
          isExpandedBody
              ? Expanded(
                  child: Scrollbar(
                    child: SmartRefresherWrapper(
                      controller: _refreshController,
                      onLoading: _onLoadMore,
                      onRefresh: _onRefresh,
                      enablePullUp: widget.canLoadMore?.call() ?? false,
                      enablePullDown: true,
                      child: ValueListenableBuilder<List<T>>(
                        valueListenable: _itemsNotifier,
                        builder: (context, items, child) {
                          return items.isEmpty
                              ? const Center(
                                  child: Text(
                                    'Không có dữ liệu',
                                  ),
                                )
                              : _buildListMutipleSelectionItems(items);
                        },
                      ),
                    ),
                  ),
                )
              : ValueListenableBuilder<List<T>>(
                  valueListenable: _itemsNotifier,
                  builder: (context, items, child) {
                    return _buildListMutipleSelectionItemsColumn(items);
                  },
                ),

          // Bottom button
          FooterWidget(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: ValueListenableBuilder<List<T>>(
              valueListenable: _selectedItemsNotifier,
              builder: (context, selectedItems, child) {
                return Row(
                  children: [
                    Expanded(
                      child: DSButton(
                        label: widget.cancelText ?? 'Bỏ chọn',
                        onPressed: _onClear,
                        variant: DSButtonVariants.tertiary,
                        isDisabled: selectedItems.isEmpty,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DSButton(
                        label:
                            '''${widget.applyText ?? 'Áp dụng'} (${selectedItems.length})''',
                        onPressed: _onConfirm,
                        variant: DSButtonVariants.primary,
                        isDisabled: _isNotChanged(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildListMutipleSelectionItems(List<T> items) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ValueListenableBuilder<List<T>>(
          valueListenable: _selectedItemsNotifier,
          builder: (context, selectedItems, child) {
            final isSelected = selectedItems.contains(item);

            if (widget.itemBuilder == null &&
                widget.getItemLabel(item).isEmpty) {
              return const SizedBox();
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TransparentInkWell(
                onTap: () => _onToggleItem(item),
                child: Builder(
                  builder: (context) {
                    if (widget.itemBuilder != null) {
                      return widget.itemBuilder!(
                        item,
                        isSelected,
                        _selectedItemsNotifier,
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors.brand.shade50
                            : colors.gray.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              widget.getItemLabel(item),
                              style: DSTextStyle().medium,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 8),
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              side: WidgetStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                  color: isSelected
                                      ? colors.brand.primary
                                      : colors.gray.shade200,
                                  width: 1,
                                ),
                              ),
                              visualDensity: VisualDensity.compact,
                              activeColor: colors.brand.primary,
                              checkColor: colors.gray.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              value: isSelected,
                              onChanged: (value) {
                                _onToggleItem(item);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildListMutipleSelectionItemsColumn(List<T> items) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items.map((item) {
        return ValueListenableBuilder<List<T>>(
          valueListenable: _selectedItemsNotifier,
          builder: (context, selectedItems, child) {
            final isSelected = selectedItems.contains(item);

            if (widget.itemBuilder == null &&
                widget.getItemLabel(item).isEmpty) {
              return const SizedBox();
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TransparentInkWell(
                onTap: () => _onToggleItem(item),
                child: Builder(
                  builder: (context) {
                    if (widget.itemBuilder != null) {
                      return widget.itemBuilder!(
                        item,
                        isSelected,
                        _selectedItemsNotifier,
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors.brand.shade50
                            : colors.gray.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              widget.getItemLabel(item),
                              style: DSTextStyle().medium,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 8),
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              side: WidgetStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                  color: isSelected
                                      ? colors.brand.primary
                                      : colors.gray.shade200,
                                  width: 1,
                                ),
                              ),
                              visualDensity: VisualDensity.compact,
                              activeColor: colors.brand.primary,
                              checkColor: colors.gray.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              value: isSelected,
                              onChanged: (value) {
                                _onToggleItem(item);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
