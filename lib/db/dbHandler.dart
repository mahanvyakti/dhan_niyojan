import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHandler {
  // Singleton pattern
  static final DBHandler _dBHandler = DBHandler._internal();
  factory DBHandler() => _dBHandler;
  DBHandler._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    const dbName = 'dhan_niyojan_database.db';
    final path = join(databasePath, dbName);

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE expenses( id INTEGER PRIMARY KEY, title TEXT, amount REAL, date TEXT, time TEXT, mode TEXT, account TEXT, category TEXT, planned INTEGER, essential INTEGER, settled INTEGER, transaction_amount REAL, location TEXT, notes TEXT, created_at TEXT, modified_at TEXT)',
    );
    
  }
}
