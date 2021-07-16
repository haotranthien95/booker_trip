import 'dart:async';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';

import 'package:new_ecom_project/core/modules/validationCreateTrip.dart';

class ValidCreateCtripBloc {
  final _validationProgressController =
      StreamController<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get validationProgressController =>
      _validationProgressController.stream;

  Future<bool> onValidateInfo(int index) async {
    TripRegisterInfo trip = tripController;
    List<String> list = [];
    int nextIndex;
    var result = Future(() async {
      switch (index) {
        case 0:
          list = ValidationCreateTrip.page1Validation(
              trip.title, trip.startDate, trip.toDate, trip.tripType);

          break;
        case 1:
          list = ValidationCreateTrip.page2Validation(
              trip.addressProvince,
              trip.addressTown,
              trip.addressVillage,
              trip.location.latitude,
              trip.location.longitude);
          break;
        case 2:
          list = ValidationCreateTrip.page3Validation(trip.slotInfo);
          break;
        case 3:
          await ValidationCreateTrip.page4Validation()
              .then((value) => list = value)
              .onError((error, stackTrace) => list = []);
          break;
      }
    }).then((value) {
      nextIndex = list.isEmpty ? index + 1 : index;
      print("BlocList:" + list.toString());
      _validationProgressController.sink
          .add({"errorMessage": list, "index": nextIndex});
      return list.isEmpty ? true : false;
    }).onError((error, stackTrace) => false);
    return result;
  }

  Future<bool> onValidateInfoLast() async {
    TripRegisterInfo trip = tripController;
    List<String> list = [];
    var result = Future(() async {
      list = ValidationCreateTrip.page1Validation(
          trip.title, trip.startDate, trip.toDate, trip.tripType);

      list.addAll(ValidationCreateTrip.page2Validation(
          trip.addressProvince,
          trip.addressTown,
          trip.addressVillage,
          trip.location.latitude,
          trip.location.longitude));

      list.addAll(ValidationCreateTrip.page3Validation(trip.slotInfo));

      await ValidationCreateTrip.page4Validation()
          .then((value) => list.addAll(value))
          .onError((error, stackTrace) => print(error));
    }).then((value) {
      _validationProgressController.sink
          .add({"errorMessage": list, "index": 5});
      print("Call aplaplaplapl ${list.isEmpty}");
      return list.isEmpty ? true : false;
    }).onError((error, stackTrace) => false);
    return result;
  }

  void dispose() {
    _validationProgressController.close();
  }
}
