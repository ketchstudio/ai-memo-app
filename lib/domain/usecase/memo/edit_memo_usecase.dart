import 'dart:async';

import '../../../core/domain/use_case.dart';
import '../../models/Memo.dart';
import '../../repository/memo_repository.dart';

class EditMemoUseCase extends UseCase<void, Memo> {
  final MemoRepository _memoRepository;

  EditMemoUseCase(this._memoRepository);

  @override
  FutureOr<void> call({required Memo params}) {
    return _memoRepository.update(params);
  }
}
