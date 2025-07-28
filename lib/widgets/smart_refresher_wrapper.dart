import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../components/ds_loading/ds_loading.dart';

class SmartRefresherWrapper extends StatelessWidget {
  const SmartRefresherWrapper({
    super.key,
    required this.controller,
    this.onRefresh,
    this.onLoading,
    this.child,
    this.scrollController,
    this.enablePullDown = true,
    this.enablePullUp = false,
  });

  final RefreshController controller;
  final bool enablePullDown;
  final bool enablePullUp;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final Widget? child;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: const BouncingScrollPhysics(),
      header: MaterialClassicHeader(
        backgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).colorScheme.primary,
      ),
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoading,
      scrollController: scrollController,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          return const Align(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: DSLoading(
                brightness: Brightness.light,
                radius: 10,
              ),
            ),
          );
        },
      ),
      child: child,
    );
  }
}
