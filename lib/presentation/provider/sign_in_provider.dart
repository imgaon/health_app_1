import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:health_app_1/data/repository/auth_repository.dart';
import 'package:health_app_1/domain/type/status_type.dart';
import 'package:health_app_1/util/prefs.dart';

class SignInProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  SignInProvider({required this.authRepository});

  late TextEditingController username;
  late TextEditingController password;
  bool usernameError = false;
  bool passwordError = false;

  Future<StatusType> login() async {
    usernameError = username.text.isEmpty;
    passwordError = password.text.isEmpty;

    if (!usernameError && !passwordError) {
      final Map<String, String> userData = {
        'identity' : username.text,
        'password' : password.text,
      };

      final result = await authRepository.login(userData: userData);
      if (result.statusCode == 200) prefs.prefs.setString('userData', jsonEncode(userData));

      return result;
    }

    notifyListeners();
    return StatusType.error;
  }
}