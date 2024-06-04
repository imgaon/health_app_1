import 'package:flutter/material.dart';
import 'package:health_app_1/presentation/component/colors.dart';
import 'package:health_app_1/presentation/component/dialog.dart';
import 'package:health_app_1/presentation/component/logo.dart';
import 'package:health_app_1/presentation/component/text_filed.dart';
import 'package:health_app_1/presentation/provider/sign_in_provider.dart';
import 'package:health_app_1/presentation/screen/home_screen.dart';
import 'package:health_app_1/presentation/screen/sign_up_screen.dart';
import 'package:health_app_1/util/di.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInProvider provider = di.get<SignInProvider>();

  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    provider.username = TextEditingController();
    provider.password = TextEditingController();
    provider.addListener(updateScreen);
  }

  @override
  void dispose() {
    provider.username.dispose();
    provider.password.dispose();
    provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
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
                hintText: 'password',
                controller: provider.password,
                error: provider.passwordError,
                obscureText: true,
              ),
              signInButton(),
              const SizedBox(height: 30),
              signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget signInButton() => InkWell(
        onTap: () async {
          final result = await provider.login();

          if (provider.usernameError || provider.passwordError) return;

          if (result.statusCode == 200 && mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          }
          if (mounted && result.statusCode != 200) showAlert(context: context, title: '로그인', result: result.message);
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
              'Sign In',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  Widget signUpButton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account?',
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            ),
            child: const Text(
              ' Sign Up',
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
}
