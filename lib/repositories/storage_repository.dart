import 'package:hive/hive.dart';

class StorageRepository {
  final String collection;
  final Box<String>? box;
  late final Box<String> db;

  StorageRepository({this.collection = 'collection', this.box}) {
    db = box ?? Hive.box<String>(collection);
  }

  List<String> values() {
    return db.values.cast<String>().toList();
  }

  Future<void> add(String key, String data) async {
    await db.put(key, data);
    return;
  }

  Future<void> delete(dynamic key) async {
    return db.delete(key);
  }

  Future<void> clear() async {
    await db.clear();
    return;
  }
}
