import 'package:flutter_template/core/utils/logger/app_logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  final Database db;

  AppDatabase._(this.db);

  static Future<AppDatabase> create() async {
    final dbPath = await getDatabasesPath();
    AppLogger.info(dbPath);
    final path = join(dbPath, 'app.db');

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cache (
            key TEXT PRIMARY KEY,
            json TEXT NOT NULL,
            expiry INTEGER NOT NULL
          )
        ''');
      },
    );

    return AppDatabase._(database);
  }
}
