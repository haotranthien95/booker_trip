import 'package:new_ecom_project/core/model/userData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String DB_NAME = "searching_his.db";
const String TABLE_HIS = "searching_his";

class DataBaseSearchingHistoryProvider {
  static final DataBaseSearchingHistoryProvider databaseProvider =
      DataBaseSearchingHistoryProvider._();
  Database? _database;

  DataBaseSearchingHistoryProvider._();

  Future<Database> get database async {
    if (_database != null) {
      print("Database controller: BD already initialize");
      print(_database!.path.toString());
      return _database!;
    }
    print("Database controller: BD has not initialize");
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    print("init DATA BASE");
    var result = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE $TABLE_HIS (id INTEGER PRIMARY KEY,key_word TEXT, count INTEGER, piority INTEGER, status TEXT)");
      },
    );
    print("CREATE TABLE SUCCESS");
    return result;
  }

  Future close() async {
    return _database!.close();
  }

  Future deleteDB() async {
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }

  searchingCache(String searchData) async {
    print("CALLLLLLLLL");
    int maxID = 0;
    int maxPI = 0;
    await _database!
        .rawQuery(
            "SELECT MAX(id) as max_id, MAX(piority) as max_pior FROM $TABLE_HIS")
        .catchError((onError) {
      print("DDay la looi 1 " + onError.toString());
    }).then((max_id) async {
      print("DDay la looi 2 ${max_id.toString()}");
      if (max_id.isNotEmpty) {
        maxID = int.parse(max_id[0]['max_id'].toString() == 'null'
                ? "0"
                : max_id[0]['max_id'].toString()) +
            1;
        maxPI = int.parse(max_id[0]['max_pior'].toString() == 'null'
                ? "0"
                : max_id[0]['max_pior'].toString()) +
            1;
      }
      print("DDay la looi 3");
      List<Map<String, Object?>> result = await _database!
          .rawQuery(
              "SELECT id,key_word,count,status FROM $TABLE_HIS WHERE key_word='$searchData'")
          .catchError((error) {
        print("DDay la looi" + error.toString());
      }).then((value) async {
        print("Meo phai loiiii " + value.toString());
        if (value.isEmpty) {
          await _database!.execute(
              "INSERT INTO $TABLE_HIS (id, key_word, count, piority, status) VALUES($maxID,'$searchData',1,$maxPI,'10')");
        } else {
          _database!.update(TABLE_HIS, <String, Object>{
            'status': 10,
            'piority': maxPI,
            'count': (num.parse(value[0]['count'].toString()) + 1)
          }, where: """id = ${int.parse(value[0]['id'].toString())}
              and key_word = '${value[0]['key_word'].toString()}'
            """);
        }
        return value;
      });
    });
    print("object Doneeeeeeeeee");

    // List<Map<String, Object?>> result = await _database!
    //     .rawQuery(
    //         'SELECT key_word,status FROM $TABLE_HIS WHERE key_word=$searchData')
    //     .catchError((error) {
    //   print(error.toString());
    // }).then((value) {
    //   print(value[0]['status']);
    //   _database!.update(TABLE_HIS, {
    //     'status': 10,
    //     'key_word': searchData
    //   }, whereArgs: [
    //     {'id': value[0]['id'], 'key_word': value[0]['key_word']}
    //   ]);
    //   return value;
    // });
  }

  Future clearHistory(String keyWord) async {
    //final db = await database;
    print("CLEAR OLD USER START");
    await _database!
        .rawQuery("DELETE FROM $TABLE_HIS WHERE key_word = '$keyWord'");
    //   await db.update(TABLE_LOGIN, {'status': 90}, where: "status = 10");
    print("CLEAR OLD USER DONE");
  }

  Future<List<Map<String, Object?>>> searchingHistoryQuery() async {
    return await _database!
        .rawQuery(
            'SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY piority DESC) ROWNUM, key_word FROM $TABLE_HIS ) WHERE ROWNUM <8')
        .catchError((error) {
      print(error.toString());
    }).then((value) {
      return value;
    });
  }
}
