import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT
      )
      """);
  }

  static Future<Database> db() async {
    final databasePath = await getDatabasesPath();

    return openDatabase(
      '$databasePath/notes.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
  }

  static Future<int> createItem(String title, String description) async {
    final db = await DatabaseService.db();
    final data = {'title': title, 'description': description};

    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseService.db();

    return db.query('items', orderBy: 'id');
  }

  static Future<void> deleteItem(int id) async {
    final db = await DatabaseService.db();

    try {
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting item: $e');
    }
  }

  static Future<int> updateItem(
    int id,
    String title,
    String description,
  ) async {
    final db = await DatabaseService.db();
    final data = {
      'title': title,
      'description': description,
    };

    final result = await db.update(
      'items',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }
}
