import 'package:bloc/bloc.dart';
import 'package:daleeli/feature/auth/domain/entity/login_entity.dart';
import 'package:daleeli/feature/auth/domain/usecase/login_use_case.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase useCase;
  LoginCubit(this.useCase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await useCase.login(email: email, password: password);

    result.fold(
      (fail) => emit(LogInFailure(errorMessage: fail.message)),
      (user) => emit(LoginSuccess(logInEntity: user)),
    );
  }
}
