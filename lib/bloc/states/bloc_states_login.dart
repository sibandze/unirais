import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  final List _props;

  LoginState({props = const []}) : this._props = props;

  @override
  List<Object> get props => _props;
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({this.error}) : super(props: [error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({@required this.token}) : super(props: [token]);
}