import 'package:flutter/material.dart';

Widget textField({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
  bool error = false,
  String errorText = '필수 입력값입니다.',
  bool obscureText = false,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            error ? errorText : '',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
