import 'dart:async';

import 'package:new_ecom_project/core/modules/validation_login.dart';

class LoginValidBloc {
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();
  bool isValidInfor(String userName, String passWord) {
    bool isNormal = true;
    if (!LoginValidate.isValidUser(userName)) {
      _userController.sink.addError("User Name invalid!");
      isNormal = false;
    } else {
      _userController.sink.add("Normal");
    }
    if (!LoginValidate.isValidPass(passWord)) {
      _passController.sink.addError("Password invalid!");
      isNormal = false;
    } else {
      _passController.sink.add("Normal");
    }
    return isNormal;
  }

  void dispose() {
    print('LoginValidBloc:Dispose');
    _userController.close();
    _passController.close();
  }

  Stream get userController => _userController.stream;
  Stream get passController => _passController.stream;
}
