import 'package:af_exam/model/contact_model.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

enum LoginColumn { id, name, number }

class SqfServices {
  SqfServices._();
  static final SqfServices instance = SqfServices._();

  String dbName = 'my_database.db';
  String tableName = 'contact_table';

  late Database _database;

  Future<void> initDatabase() async {
    String path = await getDatabasesPath();

    _database = await openDatabase(
      "$tableName/$path",
      version: 1,
      onCreate: (db, version) async {
        String sql = """CREATE TABLE IF NOT EXISTS $tableName
            (${LoginColumn.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
             ${LoginColumn.name.name} TEXT UNIQUE NOT NULL,
             ${LoginColumn.number.name} TEXT NOT NULL);""";

        await db
            .execute(sql)
            .then((value) => Logger().i("$tableName created"))
            .onError((error, stackTrace) => Logger().e("$tableName $error"));
      },
      onUpgrade: (db, v1, v2) {},
      onDowngrade: (db, v1, v2) {},
    );
  }

  Future<List<ContactModel>> getAllLoginData() async {
    List<Map<String, dynamic>> allData = await _database.query(tableName);

    allData.isNotEmpty
        ? Logger().i('!LoginDb! ${allData.length} found !!')
        : Logger().i('!LoginDb! ${allData.length} not found !!');

    return allData.map((e) => ContactModel.fromJson(e)).toList();
  }

  Future<void> addContact({required ContactModel contact}) async {
    Map<String, dynamic> data = contact.toJson();
    data.remove("id");
    await _database.insert(tableName, data);
  }
}
