import 'package:equatable/equatable.dart';
import 'package:new_ecom_project/core/model/hotTripData.dart';
import 'package:new_ecom_project/core/model/userData.dart';

abstract class GetHotTripState extends Equatable {
  const GetHotTripState();
  @override
  List<Object> get props => [];
  void dayLa() {
    print("GetHotTripState");
  }
}

class GetHotTripInitial extends GetHotTripState {
  void dayLa() {
    print("GetHotTripInitial");
  }
}

class GetHotTripLoading extends GetHotTripState {
  void dayLa() {
    print("GetHotTripLoading");
  }
}

class GetHotTripError extends GetHotTripState {
  final String error;

  GetHotTripError(this.error);
  void dayLa() {
    print("GetHotTripError");
  }
}

class GetHotTripSuccess extends GetHotTripState {
  GetHotTripSuccess(
      {required this.tripList,
      this.hasReachedEnd = false,
      this.onLoading = false}) {
    print("Create State");
    print(tripList.length.toString());
  }
  void dayLa() {
    print("GetHotTripSuccess");
  }

  final List<HotTripObject> tripList;
  final bool hasReachedEnd;
  final bool onLoading;
  @override
  // TODO: implement props
  List<Object> get props => [tripList, hasReachedEnd, onLoading];
  GetHotTripSuccess cloneWith(
      {List<HotTripObject>? listObject, bool? hasReachedEnd, bool? onLoading}) {
    return GetHotTripSuccess(
        tripList: listObject ?? this.tripList,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
        onLoading: onLoading ?? this.onLoading);
  }
}
