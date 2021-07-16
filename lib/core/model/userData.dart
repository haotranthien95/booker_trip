class UserLogin {
  String? _userToken;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _ledgerStatus;
  String? _regisDate;
  String? _permission;

  UserLogin(Map<String, dynamic> result) {
    _userToken = result['user_token'];
    _email = result['email'];
    _firstName = result['first_name'];
    _lastName = result['last_name'];
    _ledgerStatus = result['ledg_stt'];
    _regisDate = result['regis_date'];
    _permission = result['permission'];
    print('nonono ${_email}');
  }

  get userToken => _userToken;
  get email => _email;
  get firstName => _firstName;
  get lastName => _lastName;
  get ledgerStatus => _ledgerStatus;
  get regisDate => _regisDate;
  get permission => _permission;
  //final userLogin = UserLogin;
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
      ..["userToken"] = _userToken
      ..["email"] = _email
      ..["firstName"] = _firstName
      ..["lastName"] = _lastName
      ..["ledgerStatus"] = _ledgerStatus
      ..["regisDate"] = _regisDate
      ..["permission"] = _permission
      ..["status"] = 10;
  }
}
