part of 'register_cubit.dart';


sealed class RegisterState extends Equatable  {}

final class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

final class RegisterLoading extends RegisterState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class RegisterSuccess extends RegisterState {
  final RegisterEntity registerEntity;

  RegisterSuccess({required this.registerEntity});

  @override
  List<Object> get props => [registerEntity];
}

final class RegisterFailure extends RegisterState {
  final String errorMessage;

  RegisterFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
  
}
