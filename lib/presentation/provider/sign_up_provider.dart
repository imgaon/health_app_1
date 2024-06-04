import 'package:flutter/material.dart';
import 'package:health_app_1/data/repository/auth_repository.dart';
import 'package:health_app_1/domain/type/status_type.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  SignUpProvider({required this.authRepository});

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  bool usernameError = false;
  bool emailError = false;
  bool passwordError = false;


  Future<StatusType> register() async {
    usernameError = username.text.isEmpty;
    passwordError = password.text.isEmpty;
    emailError = !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email.text);

    if (!usernameError && !passwordError && !emailError) {
      final Map<String, String> userData = {
        'username' : username.text,
        'email' : email.text,
        'password' : password.text,
      };

      print('111111111111111111111');

      final result = await authRepository.register(userData: userData);

      print(result);

      return result;
    }

    notifyListeners();
    return StatusType.error;
  }
}