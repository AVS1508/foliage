// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:foliage/api/user.dart';
import 'package:foliage/components/custom_snackbar.dart';
import 'package:foliage/components/terms_and_conditions.dart';
import 'package:foliage/constants/colors.dart';
import 'package:foliage/utils/validators.dart';
import 'package:foliage/views/authentication/register_view.dart';
import 'package:foliage/views/main/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  void logInButtonClick(VoidCallback onSuccess) async {
    if (_loginFormKey.currentState!.validate()) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Image(
                      image: AssetImage('lib/assets/images/logo_alpha.png'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      controller: _emailField,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Email',
                      ),
                      validator: (value) => emailValidator(value),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      controller: _passwordField,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) => passwordValidator(value),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 45,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: CustomColors.foliageGreen,
                    ),
                    child: MaterialButton(
                      onPressed: () => logInButtonClick(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                        );
                      }),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 18,
                          color: CustomColors.trueWhite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 45,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: CustomColors.cadetGrey,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterView(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: CustomColors.trueWhite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                  const TermsAndConditionsView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
