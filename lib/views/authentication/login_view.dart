import 'package:crypto_wallet/api/flutterfire.dart';
import 'package:crypto_wallet/components/custom_snackbar.dart';
import 'package:crypto_wallet/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  void initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  void logInButtonClick(VoidCallback onSuccess) async {
    if (_formKey.currentState!.validate()) {
      await signIn(_emailField.text, _passwordField.text).then((tuple) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomSnackbar(
              isError: !tuple.item1,
              message: tuple.item2,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        if (tuple.item1) {
          onSuccess.call();
        }
      });
    }
  }

  void signUpButtonClick(VoidCallback onSuccess) async {
    await register(_emailField.text, _passwordField.text).then((tuple) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            isError: !tuple.item1,
            message: tuple.item2,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      if (tuple.item1) {
        onSuccess.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Image(
                      image:
                          AssetImage('lib/assets/icons/icon_transparent.png'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      controller: _emailField,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black45),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                      validator: (value) => emailValidator(value),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 35),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      controller: _passwordField,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black45),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                      obscureText: true,
                      validator: (value) =>
                          passwordValidator(_emailField, value),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 35),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 45,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.blue,
                    ),
                    child: MaterialButton(
                      onPressed: () => logInButtonClick(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                        );
                      }),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 35),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.blue, width: 2),
                      color: Colors.transparent,
                    ),
                    child: MaterialButton(
                      onPressed: () => signUpButtonClick(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                        );
                      }),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
