import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import 'app_database.dart';

@singleton
class LocalCacheService {
  final AppDatabase database;

  LocalCacheService(this.database);

  Future<void> save({
    required String key,
    required String json,
    required Duration ttl,
  }) async {
    final expiry = DateTime.now()
        .add(ttl)
        .millisecondsSinceEpoch;

    await database.db.insert(
      'cache',
      {
        'key': key,
        'json': json,
        'expiry': expiry,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> get(String key) async {
    final result = await database.db.query(
      'cache',
      where: 'key = ?',
      whereArgs: [key],
    );

    if (result.isEmpty) return null;

    final row = result.first;

    final expiry = row['expiry'] as int;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (now > expiry) {
      // IMPORTANT: cleanup stale cache immediately
      await clear(key);
      return null;
    }

    return row['json'] as String;
  }

  Future<void> clear(String key) async {
    await database.db.delete(
      'cache',
      where: 'key = ?',
      whereArgs: [key],
    );
  }

  /// Optional but important for real apps
  Future<void> clearExpired() async {
    final now = DateTime.now().millisecondsSinceEpoch;

    await database.db.delete(
      'cache',
      where: 'expiry < ?',
      whereArgs: [now],
    );
  }
}