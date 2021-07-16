import 'package:equatable/equatable.dart';
import 'package:new_ecom_project/core/model/userData.dart';

abstract class LoginStatusState extends Equatable {
  const LoginStatusState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginStatusInitial extends LoginStatusState {}

class LoginStatusError extends LoginStatusState {}

class LogoutStatusSuccess extends LoginStatusState {}

class LoginStatusSuccess extends LoginStatusState {
  final Map<String, dynamic> user;

  LoginStatusSuccess({required this.user});
}
