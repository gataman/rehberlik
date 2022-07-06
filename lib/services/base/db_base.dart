abstract class DBBase<T> {
  Future<String> add({required T object});
  Future<void> addAll({required List<T> list});
  Future<void> update({required T object});
  Future<void> delete({required String objectID});
}
