import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/GetUserTripEvent.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/LoginStatusEvent.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/GetUserTripState.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/LoginStatusState.dart';
import 'package:new_ecom_project/core/model/UserTripData.dart';
import 'package:new_ecom_project/core/sqlite/sqliteUserLogin.dart';
import 'package:new_ecom_project/core/services/repository.dart';

class GetUserTripBloc extends Bloc<UserTripEvent, GetUserTripState> {
  final _repository = Repository();
  DatabaseUserProvider databaseUserProvider = DatabaseUserProvider();
  @override
  GetUserTripBloc() : super(GetUserTripInitial());
  Stream<GetUserTripState> mapEventToState(UserTripEvent event) async* {
    int offset = 0;
    int SIZE = 5;
    await databaseUserProvider.database;
    try {
      if (event is GetUserTripEvent) {
        if (event.refresh) {
          yield GetUserTripLoading();
        }
        if (state is GetUserTripLoading) {
          offset = 0;
        } else if (state is GetUserTripSuccess) {
          offset = (state as GetUserTripSuccess).tripList.length;
        }

        Map<String, dynamic> userData = {};
        List<UserTripObject> result = [];
        if (state is GetUserTripLoading ||
            !(state is GetUserTripSuccess &&
                (state as GetUserTripSuccess).hasReachedEnd)) {
          await databaseUserProvider.getLoginData().then((value) {
            userData["token"] = value["user_token"];
            userData["email"] = value["email"];
            userData["hostName"] =
                value["first_name"] + " " + value["last_name"];
          }).onError((error, stackTrace) {
            throw Exception(error);
          });
          // yield GetUserTripLoading();
          await _repository.getUserTrip(userData, offset, SIZE).then((value) {
            //await _repository.getUserTrip(userData, 0, 20).then((value) {
            result.addAll(value);
          }).catchError((error) {
            print(error);
            throw Exception(error);
          });
          if (result.isEmpty) {
            yield GetUserTripSuccess(
                tripList: (state as GetUserTripSuccess).tripList,
                hasReachedEnd: true,
                hostName: userData["hostName"]);
          } else {
            print("BLAH BLAH BLAH");
            yield GetUserTripSuccess(
                tripList: (state is GetUserTripSuccess)
                    ? (state as GetUserTripSuccess).tripList + result
                    : result,
                hasReachedEnd: false,
                hostName: userData["hostName"]);
          }
        }
      }
    } catch (exception) {
      yield GetUserTripError(exception.toString());
    }
    return;
  }
}
