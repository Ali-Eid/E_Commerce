import 'package:flutter/material.dart';

import '../../../../../core/app_theme.dart';
import 'text_field_widget.dart';

class LoginWidget extends StatelessWidget {
  final emailController;
  final passwordController;
  final formkey;
  const LoginWidget({
    Key? key,
    required this.formkey,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Login Page',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            'Login in my App with clean architicture',
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFieldWidget(
              isSecure: false,
              controller: emailController,
              label: 'Email',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFieldWidget(
                isSecure: true,
                controller: passwordController,
                label: 'password'),
          ),
        ],
      ),
    );
  }
}
