import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:new_ecom_project/core/model/hotTripData.dart';

class GetHotTripAPI {
  Client client = Client();
  Future<List<HotTripObject>> getHotTripList() async {
    var result;
    await client
        .get(Uri.http("localhost:3000", "/get_hot_trip/ad_trip"), headers: {
      "Content-Type": "application/json",
    }).then((value) {
      result = onValue(value);
    }).onError((error, stackTrace) {
      print("GetHotTrip error");
      return Future.error(error.toString(), stackTrace);
    });

    print("##### Data get success #####");
    return result;
  }

  static onValue(Response response) {
    print(response.body);
    final Map<String, dynamic> responseData = json.decode(response.body);

    List<HotTripObject> data = [];
    if (response.statusCode == 200) {
      if (responseData["responseCode"] == "0000") {
        for (var element in responseData['result']) {
          data.add(HotTripObject.fromObject(element));
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
