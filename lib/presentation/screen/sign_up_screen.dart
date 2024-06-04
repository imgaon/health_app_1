import 'package:flutter/material.dart';
import 'package:health_app_1/presentation/component/colors.dart';
import 'package:health_app_1/presentation/component/dialog.dart';
import 'package:health_app_1/presentation/component/logo.dart';
import 'package:health_app_1/presentation/component/text_filed.dart';
import 'package:health_app_1/presentation/provider/sign_up_provider.dart';
import 'package:health_app_1/util/di.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpProvider provider = di.get<SignUpProvider>();

  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    provider.username = TextEditingController();
    provider.email = TextEditingController();
    provider.password = TextEditingController();
    provider.addListener(updateScreen);
  }

  @override
  void dispose() {
    provider.username.dispose();
    provider.email.dispose();
    provider.password.dispose();
    provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100 - kToolbarHeight),
          child: Column(
            children: [
              logo(),
              const SizedBox(height: 20),
              textField(
                context: context,
                hintText: 'username',
                controller: provider.username,
                error: provider.usernameError,
              ),
              textField(
                context: context,
                hintText: 'email',
                controller: provider.email,
                error: provider.emailError,
                errorText: '이메일 형식이 맞지 않습니다.',
              ),
              textField(
                context: context,
                hintText: 'password',
                controller: provider.password,
                error: provider.passwordError,
                obscureText: true,
              ),
              signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpButton() => InkWell(
    onTap: () async {
      final result = await provider.register();

      if (provider.usernameError || provider.passwordError || provider.emailError) return;

      if (result.statusCode == 200 && mounted) {
        showAlert(context: context, title: '회원가입', result: '회원가입이 완료되었습니다.', doublePop: true);
      }
      if (mounted && result.statusCode != 200) {
        showAlert(context: context, title: '회원가입', result: result.message);
      }
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
