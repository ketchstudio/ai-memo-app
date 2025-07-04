import 'dart:async';

import '../../../core/domain/use_case.dart';
import '../../models/Memo.dart';
import '../../repository/memo_repository.dart';

class InsertMemoUseCase extends UseCase<void, Memo> {
  final MemoRepository _memoRepository;

  InsertMemoUseCase(this._memoRepository);

  @override
  FutureOr<void> call({required Memo params}) {
    return _memoRepository.insert(params);
  }
}
