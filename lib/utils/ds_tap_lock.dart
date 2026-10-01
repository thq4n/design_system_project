import 'dart:async';

/// Chặn bấm liên tiếp: lần đầu chạy ngay, các lần sau bị bỏ qua đến khi
/// callback xong **và** hết [cooldown] (phòng handler sync/`unawaited`).
class DsTapLock {
  DsTapLock({this.cooldown = const Duration(milliseconds: 400)});

  final Duration cooldown;

  bool _inFlight = false;

  bool get inFlight => _inFlight;

  Future<void> run(FutureOr<void> Function()? action) async {
    if (action == null || _inFlight) {
      return;
    }
    _inFlight = true;
    try {
      await Future.wait<void>([
        Future<void>(() async {
          await action();
        }),
        Future<void>.delayed(cooldown),
      ]);
    } finally {
      _inFlight = false;
    }
  }
}
