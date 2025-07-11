import '../../domain/models/memo.dart';

class MemoRemoteDataSource {
  Future<void> deleteAllMemos() {
    return Future.value();
  }

  Future<void> deleteById(String id) {
    return Future.value();
  }

  Future<Memo?> findMemoById(String id) {
    return Future.value(null);
  }

  Future<List<Memo>> getMemos() {
    return Future.value([]);
  }

  Future<void> insert(Memo memo) {
    return Future.value();
  }

  Future<void> update(Memo memo) {
    return Future.value();
  }
}
