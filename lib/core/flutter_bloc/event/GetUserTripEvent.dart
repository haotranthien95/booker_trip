import 'package:equatable/equatable.dart';

abstract class UserTripEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetUserTripEvent extends UserTripEvent {
  GetUserTripEvent({this.refresh = false});

  final bool refresh;
}
