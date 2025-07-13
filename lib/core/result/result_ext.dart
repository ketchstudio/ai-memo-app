import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

class Nothing {
  const Nothing._();

  static const Nothing instance = Nothing._();
}

/// Synchronous version of runCatching: executes [action] and wraps in [Result]
ResultDart<T, AppError> runCatchingSync<T extends Object>(T Function() action) {
  try {
    final value = action();
    return Success(value);
  } catch (e) {
    final appErr = ErrorMapper.map(e);
    return Failure(appErr);
  }
}

/// Asynchronous version of runCatching: executes [action] and wraps in [Result]
AsyncResultDart<T, AppError> runCatchingAsync<T extends Object>(
  Future<T> Function() action,
) async {
  try {
    final value = await action();
    return Success(value);
  } catch (e) {
    print('Error in runCatchingAsync: $e');
    final appErr = ErrorMapper.map(e);
    return Failure(appErr);
  }
}

/// Asynchronous version of runCatching: executes [action] and wraps in [Result]
Future<Object> runCatchingVoid<T extends Object>(
  Future<void> Function() action,
) async {
  try {
    await action();
    return Success(Nothing.instance);
  } catch (e) {
    final appErr = ErrorMapper.map(e);
    return Failure(appErr);
  }
}
