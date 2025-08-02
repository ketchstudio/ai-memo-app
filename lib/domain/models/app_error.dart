import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_storage/uni_storage.dart';

abstract class AppError {
  final String message;

  const AppError(this.message);
}

class NetworkError extends AppError {
  const NetworkError(super.message);
}

class UnauthorizedError extends AppError {
  const UnauthorizedError(super.message);
}

class NotFoundError extends AppError {
  const NotFoundError(super.message);
}

class ServerError extends AppError {
  const ServerError(super.message);
}

class UnknownError extends AppError {
  const UnknownError(super.message);
}

AppError mapSupabaseError(Object error) {
  if (error is AppError) {
    return error; // Already an AppError, return as is
  }
  if (error is AuthException) {
    if (error.statusCode == '401') {
      return UnauthorizedError(error.message);
    }
    return ServerError(error.message);
  }

  if (error is PostgrestException) {
    switch (error.code) {
      case '42501': // insufficient_privilege
        return UnauthorizedError(error.message);
      case 'PGRST116': // not found or custom
        return NotFoundError(error.message);
      default:
        return ServerError(error.message);
    }
  }

  if (error is SocketException || error is ClientException) {
    return const NetworkError('No internet connection.');
  }

  if (error is TimeoutException) {
    return const NetworkError('Request timed out.');
  }

  if (error is FormatException) {
    return const ServerError('Invalid response format.');
  }

  return UnknownError(error.toString());
}
