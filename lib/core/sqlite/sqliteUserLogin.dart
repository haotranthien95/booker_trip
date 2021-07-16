import 'package:new_ecom_project/core/model/userData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String DB_NAME = "user_info.db";
const String TABLE_LOGIN = "userdb";

class DatabaseUserProvider {
  static final DatabaseUserProvider databaseProvider = DatabaseUserProvider();
  Database? _database;

  DatabaseUserProvider() {
    this.database;
  }

  Future<Database> get database async {
    if (_database != null) {
      print("Database controller: BD already initialize");
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
            "CREATE TABLE $TABLE_LOGIN ('user_token' TEXT PRIMARY KEY,email TEXT,first_name TEXT,last_name TEXT,ledg_stt TEXT,regis_date TEXT, permission  TEXT, status INTEGER)");
      },
    );
    print("CREATE TABLE SUCCESS");
    return result;
  }

  Future close() {
    return _database!.close();
  }

  Future deleteDB() async {
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }

  Future/*<int>*/ addUser(UserLogin userLogin) async {
    print("ADD USER START");
    print("DB INSERT: ${userLogin.userToken}");
    //final db = await database;
    await _database!.execute(
        "INSERT INTO $TABLE_LOGIN (user_token, email, first_name, last_name, ledg_stt, regis_date, permission, status) VALUES('${userLogin.userToken}','${userLogin.email}','${userLogin.firstName}','${userLogin.lastName}','${userLogin.ledgerStatus}','${userLogin.regisDate}','${userLogin.permission}',10)");
  }

  Future<bool> getLoginStatus() async {
    //final db = await database;
    final result = await _database!.rawQuery(
        'SELECT COUNT(*) AS counter FROM $TABLE_LOGIN WHERE status=10');
    print("Application in login status yn[${result[0]['counter']}]");
    return result[0]['counter'] == 1 ? true : false;
  }

  Future<Map<String, dynamic>> getLoginData() async {
    //final db = await database;
    List<Map<String, dynamic>> result;
    return await _database!
        .query(TABLE_LOGIN, distinct: false, where: "status = 10")
        .then((value) {
      result = value;
      print('In login status with ${result[0]['email']}');
      return result[0];
    }).onError((error, stackTrace) => throw Exception("DataBase querry Error"));
  }

  Future<UserLogin> getLoginDataObj() async {
    //final db = await database;
    final List<Map<String, dynamic>> result = await _database!
        .query(TABLE_LOGIN, distinct: false, where: "status = 10");
    print('In login status with ${result[0]['email']}');
    return UserLogin(result[0]);
  }

  Future<bool> clearUser() async {
    //final db = await database;
    print("CLEAR OLD USER START");
    final result = await _database!.delete(TABLE_LOGIN);
    //   await db.update(TABLE_LOGIN, {'status': 90}, where: "status = 10");
    print("CLEAR OLD USER DONE");
    return result >= 0;
  }
}
