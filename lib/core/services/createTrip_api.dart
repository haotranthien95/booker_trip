import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:new_ecom_project/core/model/UserTripData.dart';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';
import 'package:new_ecom_project/core/sqlite/sqliteUserLogin.dart';

class CreateTripAPIProvider {
  Client client = Client();
  DatabaseUserProvider databaseUserProvider =
      DatabaseUserProvider.databaseProvider;

  Future<Map<String, dynamic>> callCreateTripAPI(
      TripRegisterInfo tripRegisterInfo) async {
    await databaseUserProvider.database;
    var token = await databaseUserProvider
        .getLoginData()
        .then((value) => value)
        .onError((error, stackTrace) =>
            throw Exception("Error bay ba:" + error.toString()));
    String jsonData = tripRegisterInfo.toJSON();
    print("get token Done");
    var result;
    result = await post(Uri.http("localhost:3000", "/create/createTrip"),
        body: jsonData,
        headers: {
          "Content-Type": "application/json",
          "access_token": "${token['user_token']}",
          "email": "${token['email']}"
        }).then((value) => onValue(value)).onError(
        (error, stackTrace) => Future.error(error.toString(), stackTrace));
    return result;
  }

  static onValue(Response response) {
    print("response");
    final Map<String, dynamic> responseData = json.decode(response.body);
    List<UserTripObject> list = [];

    print(response.body);
    if (response.statusCode == 200) {
      if (responseData["responseCode"] == "0000") {
        for (var data in responseData['result']) {
          list.add(UserTripObject.fromObject(data));
        }
        return list;
      } else {
        return Future.error(responseData["errorMessage"]);
      }
    } else {
      return Future.error("Undefined Error");
    }
  }
}
