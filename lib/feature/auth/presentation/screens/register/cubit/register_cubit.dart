import 'package:bloc/bloc.dart';
import 'package:daleeli/feature/auth/data/model/register_request_model.dart';
import 'package:daleeli/feature/auth/domain/entity/register_entity.dart';
import 'package:daleeli/feature/auth/domain/usecase/register_usecase.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase useCase;
  RegisterCubit({required this.useCase}) : super(RegisterInitial());

  Future<void> createAccount({
    required RegisterRequestModel registerRequestedModel,
  }) async {
    emit(RegisterLoading());

    final result = await useCase.register(
      registerRequetModel: registerRequestedModel,
    );
    result.fold((fail) => emit(RegisterFailure(errorMessage: fail.message)), (
      user,
    ) async {
      emit(RegisterSuccess(registerEntity: user));
    });
  }
}
