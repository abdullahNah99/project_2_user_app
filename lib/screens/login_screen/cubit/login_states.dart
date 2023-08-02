import 'package:equatable/equatable.dart';
import 'package:google_maps_app/core/models/user_model.dart';

abstract class LoginStates extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginFailure extends LoginStates {
  final String failureMsg;

  LoginFailure({required this.failureMsg});
}

class LoginSuccess extends LoginStates {
  final UserModel userModel;

  LoginSuccess({required this.userModel});
}

class ChangePasswordState extends LoginStates {}
