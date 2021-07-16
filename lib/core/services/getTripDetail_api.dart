import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:new_ecom_project/core/model/detailTripData/detailTripData.dart';

class GetDetailTripAPI {
  Client client = Client();
  Future<DetailTripObject> getDetailTripData(String tripCode) async {
    var result;
    await client.get(
        Uri.http(
            "localhost:3000", "/trip_inq/trip_detail", {"trip_code": tripCode}),
        headers: {"Content-Type": "application/json"}).then((value) {
      result = onValue(value);
    }).onError((error, stackTrace) {
      print("GetUserTrip error");
      return Future.error(error.toString(), stackTrace);
    });
    return result;
  }

  static onValue(Response response) {
    print(response.body);
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseData["responseCode"] == "0000") {
        print("responseData[responseCode]");
        return DetailTripObject.fromObject(responseData);
      } else {
        return Future.error(responseData["errorMessage"]);
      }
    } else {
      return Future.error("Undefined Error");
    }
  }
}
