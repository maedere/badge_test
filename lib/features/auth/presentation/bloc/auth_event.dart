part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final String name;
  final String password;

  AuthLogin(this.name, this.password);
}

class AuthSingeUp extends AuthEvent {
  final String name;
  final String password;

  AuthSingeUp(this.name, this.password);
}
