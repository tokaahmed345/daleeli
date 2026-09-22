
import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/core/utils/router/app_router.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaleeliApp extends StatelessWidget {
  const DaleeliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute:getIt.get<FirebaseAuth>().currentUser !=null? RoutesName.main:RoutesName.splash ,
      ),
    );
    
  }
}
