import 'dart:async';

import 'package:new_ecom_project/core/services/getlisttrips_api.dart';
import 'package:new_ecom_project/core/services/repository.dart';

class TripsBloc {
  final _repository = Repository(); //Initialize API
  final _tripsFetcher = StreamController<ResponsTripsData>();

  Stream<ResponsTripsData> get allTrips => _tripsFetcher.stream; //Start Strem
  fetchAllTrips() async {
    await _repository.fetchAllTrips().then((value) {
      print('Trips: ${value.inqCount}');
      _tripsFetcher.sink.add(value);

      return value;
    }).catchError((error) {
      _tripsFetcher.addError(error);
    });
  }

  dispose() {
    print('TripsBloc:Dispose');
    _tripsFetcher.close();
  }
}

final bloc = TripsBloc();
