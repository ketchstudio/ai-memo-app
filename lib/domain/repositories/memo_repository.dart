import '../models/memo.dart';

abstract class MemoRepository {
  Future<List<Memo>> getMemos();

  Future<Memo?> findMemoById(String id);

  Future<void> insert(Memo memo);

  Future<void> update(Memo memo);

  Future<void> deleteById(String id);

  Future<void> deleteAllMemos();
}
