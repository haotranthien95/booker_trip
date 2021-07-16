import 'package:equatable/equatable.dart';

abstract class DetailTripEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetDetailTripEvent extends DetailTripEvent {
  GetDetailTripEvent(this.tripCode, {this.refresh = false});

  final bool refresh;
  final String tripCode;
}

class GetLoadingStatus extends DetailTripEvent {}
