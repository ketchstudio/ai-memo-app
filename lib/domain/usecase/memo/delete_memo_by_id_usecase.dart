import 'dart:async';

import '../../../core/domain/use_case.dart';
import '../../repository/memo_repository.dart';

class DeleteMemoByIdUseCase extends UseCase<void, String> {
  final MemoRepository _memoRepository;

  DeleteMemoByIdUseCase(this._memoRepository);

  @override
  FutureOr<void> call({required String params}) {
    return _memoRepository.deleteById(params);
  }
}
