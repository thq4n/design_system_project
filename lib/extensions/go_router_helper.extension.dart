import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

const _duplicatePushCooldown = Duration(milliseconds: 600);
final Map<String, DateTime> _recentPushKeys = {};

String _locationKey(String location) {
  return Uri.tryParse(location)?.path ?? location;
}

void _rememberPush(String key) {
  final now = DateTime.now();
  _recentPushKeys.removeWhere(
    (_, pushedAt) => now.difference(pushedAt) >= _duplicatePushCooldown,
  );
  _recentPushKeys[key] = now;
}

bool _isDuplicatePush(String key) {
  final lastPushedAt = _recentPushKeys[key];
  if (lastPushedAt == null) {
    return false;
  }
  return DateTime.now().difference(lastPushedAt) < _duplicatePushCooldown;
}

bool _isCurrentLocation(BuildContext context, String location) {
  try {
    return GoRouterState.of(context).uri.path == _locationKey(location);
  } catch (_) {
    return false;
  }
}

Future<T?> _guardedPush<T extends Object?>(
  BuildContext context,
  String location, {
  Object? extra,
}) {
  final key = _locationKey(location);
  if (_isDuplicatePush(key) || _isCurrentLocation(context, location)) {
    return Future<T?>.value(null);
  }
  _rememberPush(key);
  return GoRouter.of(context).push<T>(location, extra: extra);
}

Future<T?> _guardedPushNamed<T extends Object?>(
  BuildContext context,
  String name, {
  Map<String, String> pathParameters = const <String, String>{},
  Map<String, dynamic> queryParameters = const <String, dynamic>{},
  Object? extra,
}) {
  final key = 'named:$name';
  if (_isDuplicatePush(key)) {
    return Future<T?>.value(null);
  }
  _rememberPush(key);
  return GoRouter.of(context).pushNamed<T>(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
}

/// Drop-in thay [GoRouterHelper] của go_router: `push` / `pushNamed` bỏ qua
/// lần gọi trùng trong [_duplicatePushCooldown] hoặc khi location đã là route
/// trên cùng — chặn double-tap đẩy 2 màn hình.
extension GoRouterHelper on BuildContext {
  String namedLocation(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    String? fragment,
  }) => GoRouter.of(this).namedLocation(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    fragment: fragment,
  );

  void go(String location, {Object? extra}) =>
      GoRouter.of(this).go(location, extra: extra);

  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
    String? fragment,
  }) => GoRouter.of(this).goNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
    fragment: fragment,
  );

  Future<T?> push<T extends Object?>(String location, {Object? extra}) =>
      _guardedPush<T>(this, location, extra: extra);

  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) => _guardedPushNamed<T>(
    this,
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  bool canPop() => GoRouter.of(this).canPop();

  void pop<T extends Object?>([T? result]) => GoRouter.of(this).pop(result);

  void pushReplacement(String location, {Object? extra}) =>
      GoRouter.of(this).pushReplacement(location, extra: extra);

  void pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) => GoRouter.of(this).pushReplacementNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  void replace(String location, {Object? extra}) =>
      GoRouter.of(this).replace<Object?>(location, extra: extra);

  void replaceNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) => GoRouter.of(this).replaceNamed<Object?>(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
}
