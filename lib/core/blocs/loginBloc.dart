import 'dart:async';
//import 'package:new_ecom_project/core/model/user.dart';
import 'package:new_ecom_project/core/model/userData.dart';
import 'package:new_ecom_project/core/services/login_api.dart';
import 'package:new_ecom_project/core/services/repository.dart';
import 'package:new_ecom_project/core/sqlite/SqliteUserLogin.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'changeTabBloc.dart';

class LoginBloc {
  final _repository = Repository();
  final _loginCall = StreamController<UserLogin>();
  DatabaseUserProvider databaseProvider = DatabaseUserProvider.databaseProvider;

  Stream<UserLogin> get onLoginCall => _loginCall.stream;

  onLoginController(String email, String password) async {
    print("Bloc_pre-call");
    await databaseProvider.database;
    await databaseProvider.clearUser();
    await _repository.getUserLoginInfo(email, password).then((value) {
      // DatabaseUserProvider.databaseProvider

      print("Bloc_CALLING: ${value.email}");
      databaseProvider.addUser(value);
      databaseProvider.getLoginData();
      _loginCall.sink.add(value);
      changeViewBloc.loginStatusChangeTo(true);
      return value;
    }).catchError((error) {
      print("Catch error" + error.toString());
      _loginCall.addError(error);
    });
  }

  getLoginStatus() async {
    await databaseProvider.database;
    databaseProvider.getLoginStatus().then((value) {
      changeViewBloc.loginStatusChangeTo(value);
    }).catchError((onError) => changeViewBloc.loginStatusChangeTo(false));
  }

  dispose() {
    print('LoginBloc:Dispose');

    _loginCall.close();
  }
}

final loginBloc = LoginBloc();
