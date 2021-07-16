import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:new_ecom_project/core/model/userData.dart';

class CallLoginAPI {
  Client client = Client();
  Future<UserLogin> callLogin(String email, String password) async {
    print("##### Start...Login...Call   #####");
    var result;
    await client
        .post(
          Uri.http("localhost:3000", "/userlogin/userlogin"),
          body: {'email': email, 'password': password},
        )
        .then((value) => result = onValue(value))
        .catchError(
            (error, stackTrace) => Future.error(error.toString(), stackTrace));
    return result;
  }

  static onValue(Response response) {
    print("RESPONSE");
    if (response.statusCode == 200) {
      print("##### Data login success #####");
      print(json.decode(response.body));
      return UserLogin(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      print("##### Data Error #####");
      throw Exception('Failed to load post');
    }
  }
}
