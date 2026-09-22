part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
   final LoginEntity logInEntity;

  const LoginSuccess({required this.logInEntity});
   @override
  List<Object> get props => [logInEntity];
}
final class LogInFailure extends LoginState {
  
final String errorMessage;

  const LogInFailure({required this.errorMessage});
   @override
  List<Object> get props => [errorMessage];
}
