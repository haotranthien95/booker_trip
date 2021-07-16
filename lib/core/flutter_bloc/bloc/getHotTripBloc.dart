import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/GetHotTripEvent.dart';

import 'package:new_ecom_project/core/flutter_bloc/state/GetHotTripState.dart';

import 'package:new_ecom_project/core/model/hotTripData.dart';
import 'package:new_ecom_project/core/sqlite/sqliteUserLogin.dart';
import 'package:new_ecom_project/core/services/repository.dart';

class GetHotTripBloc extends Bloc<HotTripEvent, GetHotTripState> {
  final _repository = Repository();

  @override
  GetHotTripBloc() : super(GetHotTripInitial());
  Stream<GetHotTripState> mapEventToState(HotTripEvent event) async* {
    try {
      if (event is GetHotTripEvent) {
        yield GetHotTripLoading();

        List<HotTripObject> result = [];

        await _repository.getHotTrip().then((value) {
          result.addAll(value);
        }).catchError((error) {
          print(error);
          throw Exception(error);
        });
        yield GetHotTripSuccess(tripList: result);
      }
    } catch (exception) {
      yield GetHotTripError(exception.toString());
    }
    return;
  }
}
