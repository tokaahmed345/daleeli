import 'package:bloc_test/bloc_test.dart';
import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/auth/data/model/register_request_model.dart';
import 'package:daleeli/feature/auth/domain/entity/register_entity.dart';
import 'package:daleeli/feature/auth/domain/usecase/register_usecase.dart';
import 'package:daleeli/feature/auth/presentation/screens/register/cubit/register_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegistrationUseCase extends Mock implements RegisterUseCase {}

void main() {
  late RegisterCubit registerCubit;
  late MockRegistrationUseCase mockRegistrationUseCase;
  setUp(() {
    mockRegistrationUseCase = MockRegistrationUseCase();
    registerCubit = RegisterCubit(useCase: mockRegistrationUseCase);
  });
  tearDown(() {
    registerCubit.close();
  });
  final tRequestModel = RegisterRequestModel(
    email: "test@test.com",
    password: "password123",
    name: "toka"
  );

  final tRegisterEntity = RegisterEntity(
    email: "test@test.com",
    name: "toka"
  );
  test("InitialState should be InitialRegisterState ", () {
    expect(registerCubit.state, equals(RegisterInitial()));
  });

  blocTest<RegisterCubit, RegisterState>(
    'emits [RegisterLoading, RegisterSuccess] when Register is successful',
    build: () {
      when(() =>
        mockRegistrationUseCase.register(
          registerRequetModel:tRequestModel,
        )
      ).thenAnswer((_) async =>  Right(tRegisterEntity));
      return registerCubit;
    },
act: (registerCubit)=>registerCubit.createAccount(registerRequestedModel: tRequestModel),
expect:()=>[
RegisterLoading(),
RegisterSuccess(registerEntity: tRegisterEntity)
]
  );



  blocTest<RegisterCubit, RegisterState>(
    'emits [RegisterLoading, Register Failure] when register is Fails',
    build: () {
      when(() =>
        mockRegistrationUseCase.register(
          registerRequetModel:tRequestModel,
        )
      ).thenAnswer((_) async =>  Left(Failure("Error")));
      return registerCubit;
    },
act: (registerCubit)=>registerCubit.createAccount(registerRequestedModel: tRequestModel),
expect:()=>[
RegisterLoading(),
RegisterFailure(errorMessage: 'Error' )
]


  );



}


