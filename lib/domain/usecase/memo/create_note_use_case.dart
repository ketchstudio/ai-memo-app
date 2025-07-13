import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/domain/use_case.dart';
import '../../../core/result/result_ext.dart';
import '../../models/create_note_request.dart';
import '../../repositories/memo_repository.dart';

class InsertMemoUseCase extends UseCase<Result<void>, CreateNoteRequest> {
  final NoteRepository _memoRepository;

  InsertMemoUseCase(this._memoRepository);

  @override
  AsyncResultDart<Nothing, AppError> call({required CreateNoteRequest params}) {
    return _memoRepository.createNote(body: params);
  }
}
