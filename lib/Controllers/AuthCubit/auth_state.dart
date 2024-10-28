part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthUserThere extends AuthState {}

final class AuthUserNotThere extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  String msg;
  AuthLoginSuccess(this.msg);
}

final class AuthError extends AuthState {
  String error;
  AuthError(this.error);
}
