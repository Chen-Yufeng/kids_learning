import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Result.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  Future<void> dispose() async {
    await _database.close();
    _database = null;
  }

  _initDatabase() async {
//    print(await getDatabasesPath());
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'results.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE grades(id INTEGER PRIMARY KEY, right INTEGER, wrong INTEGER, milliseconds_since_epoch INTEGER)");
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertGrade(Grade grade) async {
    final Database db = await database;

    var map = grade.toMap();
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM grades");
    int id = table.first["id"];
    map.remove("id");
    map["id"] = id;
    await db.insert(
      'grades',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Grade>> grades() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('grades');

    return List.generate(maps.length, (i) {
      return Grade(
        id: maps[i]['id'],
        right: maps[i]['right'],
        wrong: maps[i]['wrong'],
        millisecondsSinceEpoch: maps[i]['milliseconds_since_epoch'],
      );
    });
  }

  Future<void> updateGrade(Grade grade) async {
    final db = await database;

    await db.update(
      'grades',
      grade.toMap(),
      where: "id = ?",
      whereArgs: [grade.id],
    );
  }

  Future<void> deleteGrade(Grade grade) async {
    final db = await database;

    await db.delete(
      'grades',
      where: 'id = ?',
      whereArgs: [grade.id],
    );
  }
}
