import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/daleeli_app.dart';
import 'package:daleeli/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  setupServiceLocator();

  runApp(const DaleeliApp());
}
