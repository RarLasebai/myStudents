import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/fields.dart';

class MYStudentsDatabase {
  static final MYStudentsDatabase instance = MYStudentsDatabase._init();
  static Database? _database;

  MYStudentsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("mystudents.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS $studentTable (
  ${StudentsFields.id}  INTEGER PRIMARY KEY AUTOINCREMENT,
  ${StudentsFields.studentName} TEXT NOT NULL,
  ${StudentsFields.studentGrade} DOUBLE NOT NULL,
  ${StudentsFields.studentNote} TEXT,
  ${StudentsFields.studetnWeekGrade} DOUBLE,
  ${StudentsFields.stars} INTEGER 
)
''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
