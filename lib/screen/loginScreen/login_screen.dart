import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/screen/commanWidgets/snack_bar.dart';
import 'package:musiq/screen/loginScreen/bloc/login_bloc.dart';
import 'package:musiq/screen/mainPage.dart/main_page.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          } else if (state is LoginError) {
            customSnackbar(
              context: context,
              message: state.errorMessage,
              color: Colors.red,
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    constHeight30,
                    const Text(
                      "Login",
                      style: TextStyle(fontSize: 100),
                    ),
                    constHeight40,
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Email";
                        } else if (!value.contains('@')) {
                          return "Invalid Email";
                        } else {
                          return null;
                        }
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    constHeight20,
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                    ),
                    constHeight20,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return TextButton(
                            child: state is LoginLoading
                                ? Lottie.asset(
                                    "assets/animations/buttonLoading.json",
                                    width: 50)
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      LoginEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
