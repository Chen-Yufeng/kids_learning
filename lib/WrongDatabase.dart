import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Generator.dart';
import 'Result.dart';

class WrongDBProvider {
  WrongDBProvider._();

  static final WrongDBProvider db = WrongDBProvider._();

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
      join(await getDatabasesPath(), 'wrong.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE wrong(id INTEGER PRIMARY KEY, first INTEGER, second INTEGER, answer INTEGER, operator TEXT, year INTEGER, month INTEGER, day INTEGER)");
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertQuiz(Quiz quiz) async {
    final Database db = await database;

    var map = quiz.toMap();
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM wrong");
    int id = table.first["id"];
    map.remove("id");
    map["id"] = id;
    await db.insert(
      'wrong',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertQuizList(List<Quiz> list) async {
    final Database db = await database;
    for (Quiz quiz in list) {
      var map = quiz.toMap();
      var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM wrong");
      int id = table.first["id"];
      map.remove("id");
      map["id"] = id;
      await db.insert(
        'wrong',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Quiz>> wrong() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('wrong');

    return List.generate(maps.length, (i) {
      return Quiz(
        id: maps[i]['id'],
        first: maps[i]['first'],
        second: maps[i]['second'],
        answer: maps[i]['answer'],
        operator: maps[i]['operator'],
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
      );
    });
  }

  Future<List<Quiz>> wrongOfADay(int year, int month, int day) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
        'wrong',
      where: "year = ? AND month = ? AND day = ?",
      whereArgs: [year, month, day],
    );

    return List.generate(maps.length, (i) {
      return Quiz(
        id: maps[i]['id'],
        first: maps[i]['first'],
        second: maps[i]['second'],
        answer: maps[i]['answer'],
        operator: maps[i]['operator'],
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
      );
    });
  }

  Future<void> updateQuiz(Quiz quiz) async {
    final db = await database;

    await db.update(
      'wrong',
      quiz.toMap(),
      where: "id = ?",
      whereArgs: [quiz.id],
    );
  }

  Future<void> deleteQuiz(Quiz quiz) async {
    final db = await database;

    await db.delete(
      'wrong',
      where: 'id = ?',
      whereArgs: [quiz.id],
    );
  }
}
