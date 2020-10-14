abstract class Mapper {
  dynamic findById(int id);

  Future insert(dynamic object);
  void update(dynamic object);
  void delete(dynamic object);
}