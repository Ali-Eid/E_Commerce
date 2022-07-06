import '../../../../../core/app_theme.dart';
import '../../bloc/sign_up/signup_bloc.dart';
import 'text_field_sign_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWidget extends StatelessWidget {
  final formKey;
  final nameController;
  final emailController;
  final passwordController;
  final phoneController;
  const SignUpWidget({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          const Text(
            'Sign Up',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Register in My app clean architicture',
            style: TextStyle(
              fontSize: 16,
              color: primaryColor,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFieldSignUpWidget(
                isSecure: false, controller: nameController, label: 'Name'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFieldSignUpWidget(
                isSecure: false, controller: emailController, label: 'Email'),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFieldSignUpWidget(
                isSecure: true,
                controller: passwordController,
                label: 'password'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFieldSignUpWidget(
              isSecure: false,
              controller: phoneController,
              label: 'phone',
              type: TextInputType.phone,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
