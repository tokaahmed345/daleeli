import 'package:bloc/bloc.dart';
import 'package:daleeli/feature/auth/domain/repo/register_repo.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterRepo _registerRepo;
  RegisterCubit(
      this._registerRepo
      ) : super(RegisterInitial());



  register(){
    _registerRepo.register();
  }
}