import '../../domain/models/memo.dart';
import '../../domain/repositories/memo_repository.dart';
import '../remote/memo_remote_datasource.dart';

class DefaultMemoRepository extends MemoRepository {
  final MemoRemoteDataSource _memoRemoteDataSource;

  DefaultMemoRepository(this._memoRemoteDataSource);

  @override
  Future<void> deleteAllMemos() {
    return _memoRemoteDataSource.deleteAllMemos();
  }

  @override
  Future<void> deleteById(String id) {
    return _memoRemoteDataSource.deleteById(id);
  }

  @override
  Future<Memo?> findMemoById(String id) {
    return _memoRemoteDataSource.findMemoById(id);
  }

  @override
  Future<List<Memo>> getMemos() {
    return _memoRemoteDataSource.getMemos();
  }

  @override
  Future<void> insert(Memo memo) {
    return _memoRemoteDataSource.insert(memo);
  }

  @override
  Future<void> update(Memo memo) {
    return _memoRemoteDataSource.update(memo);
  }
}
