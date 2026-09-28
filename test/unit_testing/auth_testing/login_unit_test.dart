import 'package:bloc_test/bloc_test.dart';
import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/auth/domain/entity/login_entity.dart';
import 'package:daleeli/feature/auth/domain/usecase/login_use_case.dart';
import 'package:daleeli/feature/auth/presentation/screens/login/cubit/login_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginCubit loginCubit;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginCubit = LoginCubit(mockLoginUseCase);
  });

  tearDown(() {
    loginCubit.close();
  });

  const tEmail = "test@test.com";
  const tPassword = "password123";
  const tLoginEntity = LoginEntity(  email: tEmail);

  test('initial state should be LoginInitial', () {
    expect(loginCubit.state, equals(LoginInitial()));
  });

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginSuccess] when login is successful',
    build: () {
      when(() => mockLoginUseCase.login(email: tEmail, password: tPassword))
          .thenAnswer((_) async => const Right(tLoginEntity));
      return loginCubit;
    },
    act: (cubit) => cubit.login(email: tEmail, password: tPassword),
    expect: () => [
      LoginLoading(),
      const LoginSuccess(logInEntity: tLoginEntity),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LogInFailure] when login fails',
    build: () {
      when(() => mockLoginUseCase.login(email: tEmail, password: tPassword))
          .thenAnswer((_) async =>  Left(Failure("Error")));
      return loginCubit;
    },
    act: (cubit) => cubit.login(email: tEmail, password: tPassword),
    expect: () => [
      LoginLoading(),
      const LogInFailure(errorMessage: 'Error'),
    ],
  );
}