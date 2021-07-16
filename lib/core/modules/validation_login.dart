class LoginValidate {
  static bool isValidUser(String userName) {
    if (userName == null) {
      return false;
    }
    if (userName.length < 4) {
      return false;
    }
    return true;
  }

  static bool isValidPass(String passWord) {
    if (passWord == null) {
      return false;
    }
    if (passWord.length < 6) {
      return false;
    }
    return true;
  }
}
