import 'package:flutter/material.dart';

import '../design_system_project.dart';

class AppToastWidget extends StatelessWidget {
  final String message;
  final ToastType toastType;
  final String? icon;

  const AppToastWidget({
    super.key,
    required this.message,
    this.icon,
    this.toastType = ToastType.error,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: MediaQuery.of(context).size.width - 16 * 2,
      constraints: const BoxConstraints(
        minHeight: 48,
        maxHeight: 64,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: DSRadiuses.radiusSm.borderRadiusGeometry,
        color: switch (toastType) {
          ToastType.success => colors.green.shape500,
          ToastType.error => colors.orange.shape500,
          ToastType.info => colors.blue.shape500,
        },
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DSImageView(
            source: icon ??
                switch (toastType) {
                  ToastType.success => DSAssets.vuesax.tickCircleBold,
                  ToastType.error => DSAssets.vuesax.dangerBold,
                  ToastType.info => DSAssets.vuesax.infoCircleBold,
                },
            color: colors.gray.white,
            height: 24,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              message,
              style: context.textTheme.base?.copyWithColor(colors.gray.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
