import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

class GetTripsListProvider {
  Client client = Client();

  Future<ResponsTripsData> getTripsList() async {
    print("##### Start...Get trps   #####");
    var result;
    await client
        .post(Uri.http("localhost:3000", "/mobile/fetchdata"),
            headers: {'Content-Type': 'application/json'})
        .then((value) => result = onValue(value))
        .onError(
            (error, stackTrace) => Future.error(error.toString(), stackTrace));

    print("##### Data get success #####");
    return result;
  }

  static onValue(Response response) {
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return ResponsTripsData.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class ResponsTripsData {
  List<Trips> _trips = [];
  int? _inqCount;

  ResponsTripsData.fromJson(Map<String, dynamic> parsedJson) {
    _inqCount = parsedJson["result"].length;
    print('##### Number of trips:  $_inqCount');
    List<Trips> temp = [];
    for (int i = 0; i < parsedJson['result'].length; i++) {
      Trips trips = Trips(parsedJson['result'][i]);
      temp.add(trips);
    }
    _trips = temp;
  }

  get trips => _trips;
  get inqCount => _inqCount;
}

class Trips {
  int? _id;
  String? _headerName;
  String? _rateStatus;
  String? _rateScore;
  String? _tripAddress;
  String? _tripType;
  String? _slotType;
  dynamic _finalPrice;
  dynamic _oriPrice;
  int? _remainSlot;
  String? _promotion1;
  String? _promotion2;
  String? _status;

  Trips(result) {
    //print(result);
    _id = result['id'];
    _headerName = result['headerName'];
    _rateStatus = result['rateStatus'];
    _rateScore = result['rateScore'].toString();
    _tripAddress = result['tripAddress'];
    _tripType = result['tripType'];
    _slotType = result['slotType'];
    _finalPrice = result['finalPrice'].toString();
    _oriPrice = result['oriPrice'].toString();
    _remainSlot = result['remainSlot'];
    _promotion1 = result['promotion1'];
    _promotion2 = result['promotion2'];
    _status = result['status'];
  }

  get id => _id;
  get headerName => _headerName;
  get rateStatus => _rateStatus;
  get rateScore => _rateScore;
  get tripAddress => _tripAddress;
  get tripType => _tripType;
  get slotType => _slotType;
  get finalPrice => _finalPrice;
  get oriPrice => _oriPrice;
  get remainSlot => _remainSlot;
  get promotion1 => _promotion1;
  get promotion2 => _promotion2;
  get status => _status;

  // String toString() {
  //   return '{ ${this.id},${this.rateStatus}, ${this.rateScore}, ${this.tripAddress}, ${this.tripType}, ${this.slotType}, ${this.finalPrice}, ${this.oriPrice}, ${this.remainSlot}, ${this.promotion1}, ${this.promotion2}, ${this.status} }';
  // }
}
