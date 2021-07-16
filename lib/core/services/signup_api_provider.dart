import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

class SignUpAPIProvider {
  Client client = Client();

  Future<Map<String, dynamic>> getSignUpInfo(String email, String firstName,
      String lastName, String password, String repassword) async {
    final Map<String, dynamic> loginData = {
      'email': email,
      'firstname': firstName,
      'lastname': lastName,
      'passwd': password,
      'repasswd': repassword
    };

    return await post(Uri.http("localhost:3000", "/signup/signup"),
            body: json.encode(loginData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  static onValue(Response response) {
    var result;
    print("response");
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      //var userData = responseData['data'];
      print("Success");
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': responseData
      };
    } else {
      print("Success");
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  static onError(error) {
    var result;
    print("the error is [$error]");
    result = {
      'status': false,
      'message': 'Unsuccessful Request',
      'data': error
    };
    return result;
  }
}
