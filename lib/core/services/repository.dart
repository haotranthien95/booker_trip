//import 'package:new_ecom_project/core/model/user.dart';

import 'package:new_ecom_project/core/model/detailTripData/detailTripData.dart';
import 'package:new_ecom_project/core/model/hotTripData.dart';
import 'package:new_ecom_project/core/model/UserTripData.dart';
import 'package:new_ecom_project/core/model/userData.dart';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';
import 'package:new_ecom_project/core/services/searching_api.dart';

import 'createTrip_api.dart';
import 'getHotTrip_api.dart';
import 'getHotkeyWord_api.dart';
import 'getTripDetail_api.dart';
import 'getUserTrip_api.dart';
import 'getlisttrips_api.dart';
import 'login_api.dart';

class Repository {
  final getTripsListProvider = GetTripsListProvider();
  final getUserLogin = CallLoginAPI();
  final getHotKeyWordAPI = GetHotKeyWordAPI();
  final searchTextAPI = SearchTextAPI();
  final createTripAPI = CreateTripAPIProvider();
  final getUserTripAPI = GetUserTripAPI();
  final getHotTripAPI = GetHotTripAPI();
  final getDetailTripAPI = GetDetailTripAPI();

  Future<List<HotTripObject>> getHotTrip() => getHotTripAPI.getHotTripList();

  Future<DetailTripObject> getDetailTrip(String tripCode) =>
      getDetailTripAPI.getDetailTripData(tripCode);

  Future<List<UserTripObject>> getUserTrip(
          Map<String, dynamic> token, int offset, int size) =>
      getUserTripAPI.getUserTripList(token, offset, size);

  Future<void> searchText(String text) => searchTextAPI.sendSearchRequest(text);

  Future<Map<String, dynamic>> createTrip(TripRegisterInfo data) =>
      createTripAPI.callCreateTripAPI(data);

  Future<ResponsTripsData> fetchAllTrips() =>
      getTripsListProvider.getTripsList();

  Future<List<String>> getHotKeyList() => getHotKeyWordAPI.getHotKeyList();

  Future<UserLogin> getUserLoginInfo(String email, String password) =>
      getUserLogin.callLogin(email, password);
}
