import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/LoginStatusEvent.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/LoginStatusState.dart';
import 'package:new_ecom_project/core/services/repository.dart';
import 'package:new_ecom_project/core/sqlite/sqliteUserLogin.dart';

class LoginStatusBloc extends Bloc<LoginEvent, LoginStatusState> {
  DatabaseUserProvider databaseUserProvider = DatabaseUserProvider();
  final _repository = Repository();
  @override
  LoginStatusBloc() : super(LoginStatusInitial());
  Stream<LoginStatusState> mapEventToState(LoginEvent event) async* {
    await databaseUserProvider.database;
    bool loginYN = false;
    Map<String, dynamic> userData = {};

    if (event is DoLoginEvent) {
      await databaseUserProvider.clearUser();
      await _repository
          .getUserLoginInfo(event.email, event.password)
          .then((value) {
        // DatabaseUserProvider.databaseUserProvider

        print("Bloc_CALLING: ${value.email}");
        databaseUserProvider.addUser(value);
        databaseUserProvider.getLoginData().then((value) {
          userData.addAll(value);
        });
        loginYN = true;
      }).catchError((error) {
        print("Catch error" + error.toString());
        loginYN = false;
      });
      if (loginYN) {
        yield LoginStatusSuccess(user: userData);
      } else {
        yield LogoutStatusSuccess();
      }
    }

    if (event is GetLoginEvent) {
      await databaseUserProvider.getLoginStatus().then((value) {
        loginYN = value;
      }).onError((error, stackTrace) {
        print("LoginStatusBloc error: $error:$stackTrace");
        loginYN = false;
      });
      if (loginYN) {
        await databaseUserProvider.getLoginData().then((value) {
          userData.addAll(value);
        });
        yield LoginStatusSuccess(user: userData);
      } else {
        yield LogoutStatusSuccess();
      }
    }
    if (event is LogOutEvent) {
      await databaseUserProvider.clearUser().then((value) {
        loginYN = value;
      }).onError((error, stackTrace) {
        throw Exception("Error: $error");
      });
      if (loginYN) {
        yield LogoutStatusSuccess();
      }
    }
    return;
  }
}
