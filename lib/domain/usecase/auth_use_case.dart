import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

import '../repositories/auth_repository.dart';

class GetCurrentUserIdUseCase {
  final AuthRepository _authRepository;

  GetCurrentUserIdUseCase(this._authRepository);

  ResultDart<String, AppError> call() => _authRepository.currentUserId();
}
