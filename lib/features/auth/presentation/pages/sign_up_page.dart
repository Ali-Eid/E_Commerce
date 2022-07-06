import '../../../../core/widget/awesome_dialog_failure.dart';
import '../../../../home/home_layout.dart';

import '../../../../core/app_theme.dart';
import '../bloc/sign_up/signup_bloc.dart';
import '../widgets/sign_up/sign_up_widget.dart';
import '../../../../home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Sign Up'),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is ErrorSignupState) {
          getDialogFailure(context: context, msg: state.message).show();
        }
        if (state is SuccessSignupState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeLayout()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SignUpWidget(
                emailController: emailController,
                nameController: nameController,
                passwordController: passwordController,
                formKey: _formKey,
                phoneController: phoneController,
              ),
              state is LoadingSignupState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<SignupBloc>(context).add(
                            PressSignUpEvent(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.app_registration_outlined),
                      label: const Text(
                        'register',
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
