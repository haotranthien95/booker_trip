import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetLoginEvent extends LoginEvent {}

class DoLoginEvent extends LoginEvent {
  DoLoginEvent(this.email, this.password);
  final String email;
  final String password;
}

class LogOutEvent extends LoginEvent {
  LogOutEvent({this.index = 0});
  final int index;
  get getIndex => this.index;
}
