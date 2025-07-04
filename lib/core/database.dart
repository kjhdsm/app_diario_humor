import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> deleteDb() async {
  String dbPath = await getDatabasesPath();
  String path = join(dbPath, 'diario_humor.db');
  await deleteDatabase(path);
  print('Banco de dados deletado.');
}

class AppDataBase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB('diario_humor.db');
    return _db!;
  }

  static Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE registros(
        date TEXT PRIMARY KEY,
        text TEXT,
        mood INTEGER,
        image TEXT
      )
    ''');
  }

  Future close() async {
    final db = await database;
    db.close();
  }



}