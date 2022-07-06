import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clean_architicture_ecommerce/core/app_theme.dart';
import 'package:clean_architicture_ecommerce/core/widget/awesome_dialog_failure.dart';
import 'package:clean_architicture_ecommerce/core/widget/page_transition.dart';
import 'package:clean_architicture_ecommerce/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:clean_architicture_ecommerce/features/auth/presentation/pages/sign_up_page.dart';
import 'package:clean_architicture_ecommerce/home/home_layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class MyCustomLoginUI extends StatefulWidget {
  @override
  _MyCustomLoginUIState createState() => _MyCustomLoginUIState();
}

class _MyCustomLoginUIState extends State<MyCustomLoginUI>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.ease,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller!.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller!.forward();
          }
        },
      );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ErrorLogin) {
            getDialogFailure(context: context, msg: state.message).show();
          }
          if (state is SuccessLogin) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeLayout()),
                (route) => false);
          }
        },
        builder: (context, state) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: _height,
                  child: Column(
                    children: [
                      const Expanded(child: SizedBox()),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(),
                            const Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            component1(
                              emailController,
                              Icons.email_outlined,
                              'Email...',
                              false,
                              true,
                              validate,
                            ),
                            component1(
                              passwordController,
                              Icons.lock_outline,
                              'Password...',
                              true,
                              false,
                              validate,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _width / 10),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Create a new Account',
                                      style:
                                          const TextStyle(color: primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          HapticFeedback.lightImpact();
                                          Navigator.push(context,
                                              PageTransition(SignUpPage()));
                                        },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: _width * .07),
                                height: _width * .7,
                                width: _width * .7,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      primaryColor,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Transform.scale(
                                scale: _animation!.value,
                                child: state is LoadingLoginState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          // _formkey.currentState!.validate();
                                          setState(() {
                                            //Email and password Validate
                                            emailController.text.isEmpty &&
                                                    passwordController
                                                        .text.isEmpty
                                                ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    backgroundColor:
                                                        primaryColor,
                                                    padding: EdgeInsets.all(15),
                                                    duration:
                                                        Duration(seconds: 1),
                                                    content: Text(
                                                        'Email and password is Empty')))
                                                : emailController.text.isEmpty
                                                    ? ScaffoldMessenger.of(context)
                                                        .showSnackBar(const SnackBar(
                                                            backgroundColor:
                                                                primaryColor,
                                                            padding: EdgeInsets.all(
                                                                15),
                                                            duration: Duration(
                                                                seconds: 1),
                                                            content: Text(
                                                                'Email  is Empty')))
                                                    : passwordController
                                                            .text.isEmpty
                                                        ? ScaffoldMessenger.of(context)
                                                            .showSnackBar(const SnackBar(
                                                                backgroundColor:
                                                                    primaryColor,
                                                                padding: EdgeInsets.all(15),
                                                                duration: Duration(seconds: 1),
                                                                content: Text('Password is Empty')))
                                                        : BlocProvider.of<LoginBloc>(context).add(
                                                            PressLoginEvent(
                                                              username:
                                                                  emailController
                                                                      .text,
                                                              password:
                                                                  passwordController
                                                                      .text,
                                                            ),
                                                          );
                                            validate = false;
                                          });
                                        },
                                        child: Container(
                                          height: _width * .2,
                                          width: _width * .2,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Text(
                                            'SIGN-IN',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget component1(TextEditingController controller, IconData icon,
      String hintText, bool isPassword, bool isEmail, bool validate) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width / 8,
      width: _width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: primaryColor),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: primaryColor,
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

















// import '../../../../home/home_layout.dart';

// import '../../../../core/app_theme.dart';
// import '../bloc/login/login_bloc.dart';
// import 'sign_up_page.dart';
// import '../widgets/login_page/login_btn_widget.dart';
// import '../widgets/login_page/login_widget.dart';
// import '../../../../home/home_page.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       centerTitle: true,
//       title: const Text('Login Page'),
//     );
//   }

//   Widget _buildBody() {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();
//     final _formkey = GlobalKey<FormState>();
//     return BlocConsumer<LoginBloc, LoginState>(
//       listener: (context, state) {
//         if (state is SuccessLogin) {
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (_) => const HomeLayout()),
//               (route) => false);
//         }
//       },
//       builder: (context, state) {
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               LoginWidget(
//                 emailController: emailController,
//                 formkey: _formkey,
//                 passwordController: passwordController,
//               ),
//               state is LoadingLoginState
//                   ? const CircularProgressIndicator(
//                       color: primaryColor,
//                     )
//                   : SizedBox(
//                       width: 150,
//                       child: LoginBtnWidget(
//                         label: 'Login',
//                         onPressed: () {
//                           // if (_formkey.currentState!.validate()) {
//                           BlocProvider.of<LoginBloc>(context).add(
//                             PressLoginEvent(
//                               username: emailController.text,
//                               password: passwordController.text,
//                             ),
//                           );
//                           // }
//                         },
//                       ),
//                     ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextButton.icon(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (_) => const SignUpPage()));
//                 },
//                 icon: const Icon(Icons.create),
//                 label: const Text('Create Account'),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
