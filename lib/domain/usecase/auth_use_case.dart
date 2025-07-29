import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

import '../repositories/auth_repository.dart';

class GetCurrentUserIdUseCase {
  final AuthRepository _authRepository;

  GetCurrentUserIdUseCase(this._authRepository);

  AsyncResultDart<String, AppError> call() => runCatchingAsync(() async {
    final userId = _authRepository.currentUserId;
    if (userId == null || userId.isEmpty) {
      throw AuthenticationError('No user is currently logged in.');
    } else {
      return userId;
    }
  });
}
