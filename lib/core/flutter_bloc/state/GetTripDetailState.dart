import 'package:equatable/equatable.dart';
import 'package:new_ecom_project/core/model/detailTripData/detailTripData.dart';
import 'package:new_ecom_project/core/model/hotTripData.dart';
import 'package:new_ecom_project/core/model/userData.dart';

abstract class GetDetailTripState extends Equatable {
  const GetDetailTripState();
  @override
  List<Object> get props => [];
  void dayLa() {
    print("DAY LA: GetDetailTripState");
  }
}

class GetDetailTripInitial extends GetDetailTripState {
  void dayLa() {
    print("DAY LA: GetDetailTripInitial");
  }
}

class GetDetailTripLoading extends GetDetailTripState {
  void dayLa() {
    print("DAY LA: GetDetailTripLoading");
  }
}

class GetDetailTripError extends GetDetailTripState {
  final String error;

  GetDetailTripError(this.error);
  void dayLa() {
    print("DAY LA: GetDetailTripError");
  }
}

class GetDetailTripSuccess extends GetDetailTripState {
  GetDetailTripSuccess({required this.trip, this.isloading = true});
  void dayLa() {
    print("DAY LA: GetDetailTripSuccess");
  }

  final DetailTripObject trip;
  final bool isloading;
  @override
  // TODO: implement props
  List<Object> get props => [trip, isloading];
  GetDetailTripSuccess cloneWith({DetailTripObject? trip, bool? isloading}) {
    return GetDetailTripSuccess(
        trip: trip ?? this.trip, isloading: isloading ?? this.isloading);
  }
}
