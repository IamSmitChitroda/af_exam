import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/contact_model.dart';

class DBService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'contacts.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            number TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertContact(Contact contact) async {
    final dbClient = await db;
    return await dbClient.insert('contacts', contact.toMap());
  }

  Future<List<Contact>> getContacts() async {
    final dbClient = await db;
    final maps = await dbClient.query('contacts');
    return maps.map((map) => Contact.fromMap(map)).toList();
  }

  Future<int> updateContact(Contact contact) async {
    final dbClient = await db;
    return await dbClient.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> deleteContact(int id) async {
    final dbClient = await db;
    return await dbClient.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
