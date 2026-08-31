import 'package:flutter/material.dart';
import '../../design_system_project.dart';

class FilterSelectionModal<T> extends StatefulWidget {
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
  final T? initialSelectedItem;
  final ValueNotifier<T?>? selectedItemNotifier;
  final Widget Function(
    T item,
    bool isSelected,
    ValueNotifier<T?>? selectedItemNotifier,
    Function(T item)? onSelect,
  )? itemBuilder;
  final Function(T? item)? onConfirm;
  final bool isShowDismissButton;
  final Function()? onDismiss;
  final String? applyText;
  final String? cancelText;
  final RefreshController? refreshController;
  final bool dismissWhenAction;
  final bool Function(T? selectedItem)? onDisableAction;

  const FilterSelectionModal({
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
    this.initialSelectedItem,
    this.selectedItemNotifier,
    this.itemBuilder,
    this.onConfirm,
    required this.isShowDismissButton,
    this.onDismiss,
    this.applyText,
    this.cancelText,
    required this.dismissWhenAction,
    this.onDisableAction,
  });

  @override
  State<FilterSelectionModal<T>> createState() =>
      _FilterSelectionModalState<T>();
}

class _FilterSelectionModalState<T> extends State<FilterSelectionModal<T>> {
  late final ValueNotifier<T?> _selectedItemNotifier =
      (widget.selectedItemNotifier ?? ValueNotifier(null))
        ..value = widget.initialSelectedItem;
  List<T> _items = [];
  String? _searchTerm;
  late Debouncer _debouncer;
  late final _refreshController =
      widget.refreshController ??
      RefreshController(
        initialRefresh: widget.initialItems?.isEmpty ?? true,
      );

  set selectedItem(T? item) {
    _selectedItemNotifier.value = item;
  }

  bool get isHasFetchItems =>
      widget.onRefreshItems != null || widget.onLoadMoreItems != null;

  bool get isExpandedBody => isHasFetchItems;

  @override
  void initState() {
    super.initState();
    _items = widget.initialItems?.toList() ?? [];
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
    super.dispose();
  }

  Future<void> _onRefresh() async {
    try {
      final items =
          await widget.onRefreshItems?.call(searchTerm: _searchTerm) ?? [];
      setState(() {
        _items = items.isNotEmpty ? [...items] : [];
      });
      _refreshController
        ..refreshCompleted()
        ..loadComplete();
    } catch (_) {
      _refreshController
        ..refreshFailed()
        ..loadFailed();
    }
  }

  Future<void> _onLoadMore() async {
    try {
      final items =
          await widget.onLoadMoreItems?.call(searchTerm: _searchTerm) ?? [];
      if (items.isNotEmpty) {
        setState(() => _items.addAll(items));
      }
      _refreshController
        ..refreshCompleted()
        ..loadComplete();
    } catch (_) {
      _refreshController
        ..refreshFailed()
        ..loadFailed();
    }
  }

  bool _isNotChanged(T? selectedItem) {
    if (widget.onDisableAction != null) {
      return widget.onDisableAction!(_selectedItemNotifier.value);
    }
    return selectedItem == widget.initialSelectedItem;
  }

  Widget _buildListItem(T item) {
    return ValueListenableBuilder<T?>(
      valueListenable: _selectedItemNotifier,
      builder: (context, value, child) {
        final isSelected = value == item;

        if (widget.itemBuilder == null && widget.getItemLabel(item).isEmpty) {
          return const SizedBox();
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: TransparentInkWell(
            onTap: () => _onSelect(item),
            child: Builder(
              builder: (context) {
                if (widget.itemBuilder != null) {
                  return widget.itemBuilder!(
                    item,
                    isSelected,
                    _selectedItemNotifier,
                    _onSelect,
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
                      DSRadio(
                        value: item,
                        groupValue: value,
                        onChanged: (newValue) {
                          if (newValue != null) {
                            selectedItem = newValue;
                          }
                        },
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
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomModal<T>(
      title: widget.title,
      titlePadding: widget.titlePadding,
      isShowDismissButton: widget.isShowDismissButton,
      onDismiss: widget.onDismiss,
      applyText: widget.applyText,
      cancelText: widget.cancelText,
      dismissWhenAction: widget.dismissWhenAction,
      onDisableAction: widget.onDisableAction,
      isChanged: _isNotChanged,
      selectedItemNotifier: _selectedItemNotifier,
      initialData: widget.initialSelectedItem,
      isExpandedBody: isExpandedBody,
      itemBuilder: (
        item,
        isSelected,
        selectedItemNotifier,
      ) {
        return widget.itemBuilder!(
          item,
          isSelected,
          selectedItemNotifier,
          _onSelect,
        );
      },
      onConfirm: widget.onConfirm,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
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
          if (isExpandedBody)
            Expanded(
              child: BottomSheetListFrame(
                shrinkWrap: true,
                refreshController: _refreshController,
                onRefresh: _onRefresh,
                onLoadMore:
                    widget.onLoadMoreItems != null ? _onLoadMore : null,
                enablePullUp: widget.canLoadMore?.call() ?? false,
                enablePullDown: true,
                itemCount: _items.length,
                itemBuilder: (context, index) => _buildListItem(_items[index]),
                emptyWidget: const Center(child: Text('Không có dữ liệu')),
              ),
            )
          else
            ..._items.map(_buildListItem),
        ],
      ),
    );
  }

  void _onSelect(T item) {
    selectedItem = item;
  }
}
