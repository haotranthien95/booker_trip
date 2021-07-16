import 'package:equatable/equatable.dart';

abstract class HotTripEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetHotTripEvent extends HotTripEvent {
  GetHotTripEvent({this.refresh = false});

  final bool refresh;
}
