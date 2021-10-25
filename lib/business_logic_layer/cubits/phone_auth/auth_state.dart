part of 'auth_cubit.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState{}

class ErrorState extends AuthState{
  final String error;

  ErrorState(this.error);
}

class PhoneNumberSubmitted extends AuthState{}

class PhoneNumberVerified extends AuthState{}
