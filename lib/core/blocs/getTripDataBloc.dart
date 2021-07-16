import 'dart:async';

import 'package:new_ecom_project/core/services/getlisttrips_api.dart';
import 'package:new_ecom_project/core/services/repository.dart';

class GetTripDataBloc {
  final _repository = Repository(); //Initialize API
  final _gettripDatasFetcher = StreamController<ResponsTripsData>();

  Stream<ResponsTripsData> get allTrips =>
      _gettripDatasFetcher.stream; //Start Strem
  fetchAllTrips() async {
    await _repository.fetchAllTrips().then((value) {
      print('Trips: ${value.inqCount}');
      _gettripDatasFetcher.sink.add(value);

      return value;
    }).catchError((error) {
      _gettripDatasFetcher.addError(error);
    });
  }

  dispose() {
    print('TripsBloc:Dispose');
    _gettripDatasFetcher.close();
  }
}
