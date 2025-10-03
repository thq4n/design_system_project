import 'package:flutter/material.dart';

import '../design_system_project.dart';

export 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
export 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart'
    show RefreshController;

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
        backgroundColor: DSColorUsages.background.primary,
        color: DSColorUsages.icon.brand,
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
