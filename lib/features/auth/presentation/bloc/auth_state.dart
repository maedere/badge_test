part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Person person;
  AuthSuccess(this.person);
}

class AuthFail extends AuthState {
  final String errorMessage;

  AuthFail(this.errorMessage);
}
