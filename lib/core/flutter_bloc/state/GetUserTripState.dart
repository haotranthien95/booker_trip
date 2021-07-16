import 'package:equatable/equatable.dart';
import 'package:new_ecom_project/core/model/UserTripData.dart';
import 'package:new_ecom_project/core/model/userData.dart';

abstract class GetUserTripState extends Equatable {
  const GetUserTripState();
  @override
  List<Object> get props => [];
  void dayLa() {
    print("GetUserTripState");
  }
}

class GetUserTripInitial extends GetUserTripState {
  void dayLa() {
    print("GetUserTripInitial");
  }
}

class GetUserTripLoading extends GetUserTripState {
  void dayLa() {
    print("GetUserTripLoading");
  }
}

class GetUserTripError extends GetUserTripState {
  final String error;

  GetUserTripError(this.error);
  void dayLa() {
    print("GetUserTripError");
  }
}

class GetUserTripSuccess extends GetUserTripState {
  GetUserTripSuccess({
    required this.tripList,
    this.hasReachedEnd = false,
    this.onLoading = false,
    required this.hostName,
  });
  void dayLa() {
    print("GetUserTripSuccess");
  }

  final List<UserTripObject> tripList;
  final bool hasReachedEnd;
  final bool onLoading;
  final String hostName;
  @override
  // TODO: implement props
  List<Object> get props => [tripList, hasReachedEnd, onLoading, hostName];
  GetUserTripSuccess cloneWith(
      {List<UserTripObject>? listObject,
      bool? hasReachedEnd,
      bool? onLoading,
      String? hostName}) {
    return GetUserTripSuccess(
        tripList: listObject ?? this.tripList,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
        onLoading: onLoading ?? this.onLoading,
        hostName: hostName ?? this.hostName);
  }
}
