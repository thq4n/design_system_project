part of 'extensions.dart';

extension StateExtension<T extends StatefulWidget> on State<T> {
  DSTextTheme get textTheme => context.textTheme;
  DSColors get colors => context.colors;

  Widget buildEmptyState({
    String? message = 'Không có dữ liệu',
    String? subMessage,
    EdgeInsetsGeometry padding = const EdgeInsets.all(40),
    double imageSize = 200.0,
    DSEmptyStateType type = DSEmptyStateType.question,
  }) {
    return DSEmptyState(
      type: type,
      message: message,
      subMessage: subMessage,
      padding: padding,
      imageSize: imageSize,
    );
  }
}
