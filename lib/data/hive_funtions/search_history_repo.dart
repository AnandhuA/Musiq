import 'package:hive/hive.dart';

class SearchHistoryRepo {
  static const String _boxName = 'search_history';


  static Future<void> saveSearchQuery(String query) async {
    var box = Hive.box<String>(_boxName);

    if (box.containsKey(query)) {
      box.delete(query);
    }

    await box.put(query, query);

    if (box.length > 10) {
      await box.deleteAt(0);
    }
  }

  static List<String> getSearchHistory() {
    var box = Hive.box<String>(_boxName);
    return box.values.toList().reversed.toList();
  }

  static Future<void> deleteSearchQuery(String query) async {
    var box = Hive.box<String>(_boxName);
    await box.delete(query);
  }

  static Future<void> clearSearchHistory() async {
    var box = Hive.box<String>(_boxName);
    await box.clear();
  }
}
