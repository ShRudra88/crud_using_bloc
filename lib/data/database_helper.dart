import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'note_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<List<Note>> getNotes() async {
    final dbClient = await db;
    final result = await dbClient.query('notes');
    return result.map((e) => Note.fromMap(e)).toList();
  }

  Future<int> insertNote(Note note) async {
    final dbClient = await db;
    return await dbClient.insert('notes', note.toMap());
  }

  Future<int> updateNote(Note note) async {
    final dbClient = await db;
    return await dbClient.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    final dbClient = await db;
    return await dbClient.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
