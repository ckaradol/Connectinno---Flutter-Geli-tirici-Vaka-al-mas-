part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class SignInWithGoogle extends AuthEvent {}

class SignInWithEmailPassword extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailPassword(this.email, this.password);
}

class SignUpWithEmailPassword extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  SignUpWithEmailPassword(this.email, this.password, this.displayName);
}

class SignOutRequested extends AuthEvent {}

