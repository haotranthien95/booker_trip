import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:new_ecom_project/core/model/UserTripData.dart';

class GetUserTripAPI {
  Client client = Client();
  Future<List<UserTripObject>> getUserTripList(
      Map<String, dynamic> token, int offset, int size) async {
    var result;
    print(token['token'].toString());
    print("offset:" + offset.toString());
    print("size:" + size.toString());
    await client.get(
        Uri.http("localhost:3000", "/user/fetch_data",
            {"size": size.toString(), "offset": offset.toString()}),
        headers: {
          "Content-Type": "application/json",
          "access_token": "${token['token']}",
          "email": "${token['email']}"
        }).then((value) {
      result = onValue(value);
    }).onError((error, stackTrace) {
      print("GetUserTrip error");
      return Future.error(error.toString(), stackTrace);
    });

    print("##### Data get success #####");
    return result;
  }

  static onValue(Response response) {
    print(response.body);
    final Map<String, dynamic> responseData = json.decode(response.body);

    List<UserTripObject> data = [];
    if (response.statusCode == 200) {
      if (responseData["responseCode"] == "0000") {
        for (var element in responseData['result']) {
          data.add(UserTripObject.fromObject(element));
        }

        return data;
      } else {
        return Future.error(responseData["errorMessage"]);
      }
    } else {
      return Future.error("Undefined Error");
    }
  }
}
