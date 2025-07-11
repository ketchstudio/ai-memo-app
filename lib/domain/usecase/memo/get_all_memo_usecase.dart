import 'dart:async';

import 'package:ana_flutter/core/domain/use_case.dart';

import '../../models/memo.dart';
import '../../repositories/memo_repository.dart';

class GetAllMemoUseCase extends UseCase<List<Memo>, void> {
  final MemoRepository _memoRepository;

  GetAllMemoUseCase(this._memoRepository);

  @override
  FutureOr<List<Memo>> call({required void params}) {
    return _memoRepository.getMemos();
  }
}
