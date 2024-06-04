import 'package:flutter/material.dart';
import 'package:health_app_1/data/repository/auth_repository.dart';
import 'package:health_app_1/data/service/api_service.dart';
import 'package:health_app_1/presentation/provider/home_provider.dart';
import 'package:health_app_1/presentation/provider/sign_in_provider.dart';
import 'package:health_app_1/presentation/provider/sign_up_provider.dart';
import 'package:health_app_1/presentation/screen/home_screen.dart';
import 'package:health_app_1/presentation/screen/sign_in_screen.dart';
import 'package:health_app_1/util/di.dart';
import 'package:health_app_1/util/prefs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  prefs.init();

  final ApiService apiService = ApiService();

  final AuthRepository authRepository = AuthRepository(apiService: apiService);

  final SignUpProvider signUpProvider = SignUpProvider(authRepository: authRepository);
  final SignInProvider signInProvider = SignInProvider(authRepository: authRepository);
  final HomeProvider homeProvider = HomeProvider();

  di.set(signInProvider);
  di.set(signUpProvider);
  di.set(homeProvider);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    )
  );
}