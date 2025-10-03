import 'dart:async';

/// A utility class that provides debouncing functionality for values.
///
/// Debouncing delays the execution of a callback until after a specified
/// duration has passed since the last time the value was set.
///
/// Example usage:
/// ```dart
/// final debouncer = Debouncer<String>(
///   Duration(milliseconds: 500),
///   (value) => print('Debounced value: $value'),
/// );
///
/// debouncer.value = 'Hello';
/// debouncer.value = 'World'; // Only 'World' will be printed after 500ms
/// ```
class Debouncer<T> {
  /// The duration to wait before executing the callback.
  final Duration duration;

  /// The callback function to execute with the debounced value.
  final void Function(T? value) onValue;

  /// Creates a new [Debouncer] with the specified [duration] and [onValue]
  /// callback.
  Debouncer(this.duration, this.onValue);

  T? _value;
  Timer? _timer;

  /// The current value being debounced.
  T? get value => _value;

  var _isDebouncing = false;

  /// Whether the debouncer is currently waiting to execute the callback.
  bool get debouncing => _isDebouncing;

  /// Sets a new value and starts/resets the debounce timer.
  ///
  /// If a timer is already running, it will be cancelled and a new one started.
  set value(T? val) {
    _isDebouncing = true;
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () {
      _isDebouncing = false;
      onValue(_value);
    });
  }

  /// Cancels the current debounce timer.
  ///
  /// This will prevent the callback from being executed if called before
  /// the duration has elapsed.
  void cancel() {
    _timer?.cancel();
    _isDebouncing = false;
  }

  /// Disposes of the debouncer by cancelling any active timer.
  ///
  /// Should be called when the debouncer is no longer needed to prevent
  /// memory leaks.
  void dispose() {
    cancel();
  }
}

/// A void callback, i.e. (){}, so we don't need to import e.g. `dart.ui`
/// just for the VoidCallback type definition.
typedef EasyDebounceCallback = void Function();

class _EasyDebounceOperation {
  EasyDebounceCallback callback;
  Timer timer;
  _EasyDebounceOperation(this.callback, this.timer);
}

/// A static class for handling method call debouncing.
class EasyDebounce {
  static final Map<String, _EasyDebounceOperation> _operations = {};

  /// Will delay the execution of [onExecute] with the given [duration]. If
  /// another call to debounce() with the same [tag] happens within this
  /// duration, the first call will be cancelled and the debouncer will start
  /// waiting for another [duration] before executing
  /// [onExecute].
  ///
  /// [tag] is any arbitrary String, and is used to identify this particular
  /// debounce
  /// operation in subsequent calls to [debounce()] or [cancel()].
  ///
  /// If [duration] is `Duration.zero`, [onExecute] will be executed
  /// immediately, i.e.
  /// synchronously.
  static void debounce(
    String tag,
    Duration duration,
    EasyDebounceCallback onExecute,
  ) {
    if (duration == Duration.zero) {
      _operations[tag]?.timer.cancel();
      _operations.remove(tag);
      onExecute();
    } else {
      _operations[tag]?.timer.cancel();

      _operations[tag] = _EasyDebounceOperation(
        onExecute,
        Timer(duration, () {
          _operations[tag]?.timer.cancel();
          _operations.remove(tag);

          onExecute();
        }),
      );
    }
  }

  /// Fires the callback associated with [tag] immediately. This does not cancel
  /// the debounce timer,
  /// so if you want to invoke the callback and cancel the debounce timer, you
  /// must first call
  /// `fire(tag)` and then `cancel(tag)`.
  static void fire(String tag) {
    _operations[tag]?.callback();
  }

  /// Cancels any active debounce operation with the given [tag].
  static void cancel(String tag) {
    _operations[tag]?.timer.cancel();
    _operations.remove(tag);
  }

  /// Cancels all active debouncers.
  static void cancelAll() {
    for (final operation in _operations.values) {
      operation.timer.cancel();
    }
    _operations.clear();
  }

  /// Returns the number of active debouncers (debouncers that haven't yet
  /// called their
  /// [onExecute] methods).
  static int count() {
    return _operations.length;
  }
}
