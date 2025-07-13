import 'package:equatable/equatable.dart';

/// Base application error
abstract class AppError extends Equatable implements Exception {
  final String message;

  const AppError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Specific error types
class NetworkError extends AppError {
  const NetworkError(super.message);
}

class ValidationError extends AppError {
  const ValidationError(super.message);
}

class DatabaseError extends AppError {
  const DatabaseError(super.message);
}

class UnexpectedError extends AppError {
  const UnexpectedError(super.message);
}

/// Error mapper to convert exceptions into AppError
class ErrorMapper {
  /// Map Supabase error codes or other exceptions to AppError
  static AppError map(Object error) {
    if (error is AppError) {
      return error;
    }
    // Handle Supabase specific errors
    // Fallback
    return UnexpectedError(error.toString());
  }
}
