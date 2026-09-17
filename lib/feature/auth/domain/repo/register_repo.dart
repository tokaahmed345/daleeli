import 'package:dio/dio.dart';

class RegisterRepo {

  final Dio _dio;
  RegisterRepo(this._dio);



  register()async{
    try{
      final response=await _dio.post('path',data: {

      });
    }catch(e){

    }
  }
}