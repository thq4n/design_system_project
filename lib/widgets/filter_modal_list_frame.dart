import 'package:flutter/material.dart';

import '../design_system_project.dart';

class FilterModalListFrame extends StatefulWidget {
  final Widget? child;
  final List<Widget>? children;
  final int? itemCount;
  final Widget Function(BuildContext context, int index)? itemBuilder;
  final Widget? emptyWidget;
  final RefreshController? refreshController;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  final bool enablePullUp;
  final bool enablePullDown;
  final bool shrinkWrap;

  const FilterModalListFrame({
    super.key,
    this.child,
    this.children,
    this.itemCount,
    this.itemBuilder,
    this.emptyWidget,
    this.refreshController,
    this.onRefresh,
    this.onLoadMore,
    this.enablePullUp = false,
    this.enablePullDown = true,
    this.shrinkWrap = false,
  }) : assert(
         (child != null && children == null && itemCount == null) ||
             (child == null && children != null && itemCount == null) ||
             (child == null &&
                 children == null &&
                 itemCount != null &&
                 itemBuilder != null),
         'Chỉ dùng một trong: child, children, hoặc itemCount+itemBuilder',
       );

  @override
  State<FilterModalListFrame> createState() => _FilterModalListFrameState();
}

class _FilterModalListFrameState extends State<FilterModalListFrame> {
  RefreshController? _ownedRefreshController;

  bool get _usesRefresh =>
      widget.refreshController != null || widget.onRefresh != null;

  RefreshController get _effectiveRefreshController =>
      widget.refreshController ??
      (_ownedRefreshController ??= RefreshController());

  @override
  void dispose() {
    _ownedRefreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var content = _buildContent(context);
    if (_usesRefresh) {
      content = SmartRefresherWrapper(
        controller: _effectiveRefreshController,
        onRefresh: () => widget.onRefresh?.call(),
        onLoading: () => widget.onLoadMore?.call(),
        enablePullUp: widget.enablePullUp,
        enablePullDown: widget.enablePullDown,
        child: content,
      );
    }
    if (widget.shrinkWrap) {
      return content;
    }
    return Expanded(child: content);
  }

  Widget _buildContent(BuildContext context) {
    if (widget.child != null) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: widget.child,
      );
    }
    if (widget.children != null) {
      if (widget.children!.isEmpty) {
        return _buildScrollableEmpty(context);
      }
      return ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: widget.shrinkWrap,
        children: widget.children!,
      );
    }
    if (widget.itemCount != null && widget.itemBuilder != null) {
      if (widget.itemCount! == 0) {
        return _buildScrollableEmpty(context);
      }
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: widget.shrinkWrap,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder!,
      );
    }
    return widget.emptyWidget ?? const SizedBox.shrink();
  }

  Widget _buildScrollableEmpty(BuildContext context) {
    final empty = widget.emptyWidget ??
        const Center(child: Text('Không có dữ liệu'));
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: constraints.maxHeight,
              child: empty,
            ),
          ],
        );
      },
    );
  }
}
