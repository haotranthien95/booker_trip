import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';

class ChangeLocationBloc {
  final _changeLocationMainController = StreamController<LatLng>();

  Stream<LatLng> get changeLocationMainStream =>
      _changeLocationMainController.stream;

  onChangeLocation(LatLng latLng) async {
    _changeLocationMainController.sink.add(latLng);
    tripController.location = latLng;
    print("===Selected Location:${latLng.toString()}");
    print("===Selected LocationA:${tripController.location.toString()}");
  }

  void dispose() {
    //_changeLocationMapController.close();
    _changeLocationMainController.close();
    print("ChangeLocationStream:Stream disposed");
  }
}

class ChangeLocationMapBloc {
  final _changeLocationMapController = StreamController<LatLng>();
  Stream<LatLng> get changeLocationMapStream =>
      _changeLocationMapController.stream;
  onChangeMapLocation(LatLng latLng) async {
    //_changeLocationMainController.sink.add(latLng);
    _changeLocationMapController.sink.add(latLng);
    print("Map Change${latLng.toString()}");
  }

  void dispose() {
    _changeLocationMapController.close();
    //_changeLocationMainController.close();
    print("changeLocationMapStream:Stream disposed");
  }
}
//final searchingHintBloc = SearchingHintBloc();

