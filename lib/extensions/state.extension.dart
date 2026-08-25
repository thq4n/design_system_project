part of 'extensions.dart';

extension StateExtension on State {
  DSTextTheme get textTheme => context.textTheme;
  DSColors get colors => context.colors;

   Widget buildEmptyState({
    String? message = 'Không có dữ liệu',
    String? subMessage,
    EdgeInsetsGeometry padding = const EdgeInsets.all(40),
    double imageSize = 200.0,
  }) {
    return Padding(
      padding: padding,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          DSImageView(
            source: DSAssets.emptyState.iconEmptyStateQuestion,
            width: imageSize,
            height: imageSize,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message,
              style: textTheme.lg?.semibold,
              textAlign: TextAlign.center,
            ),
          ],
          if (subMessage != null)
            ...[
              Text(
                subMessage,
                style: textTheme.base?.regular.copyWithColor(
                  DSColorUsages.text.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ].withSeparators(separator: const SizedBox(height: 8)),
        ],
      ),
    );
  }
}
