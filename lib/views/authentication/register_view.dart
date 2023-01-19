// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:foliage/api/flutterfire.dart';
import 'package:foliage/components/custom_snackbar.dart';
import 'package:foliage/constants/colors.dart';
import 'package:foliage/utils/validators.dart';
import 'package:foliage/views/main/home_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _displayNameField = TextEditingController();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _confirmPasswordField = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

  void signUpButtonClick(VoidCallback onSuccess) async {
    if (_registerFormKey.currentState!.validate()) {
      await register(
              _displayNameField.text, _emailField.text, _passwordField.text)
          .then((tuple) {
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
              key: _registerFormKey,
              child: Column(
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
                      controller: _displayNameField,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(),
                        labelText: 'Display Name',
                        hintText: 'Display Name',
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      controller: _confirmPasswordField,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
                      ),
                      obscureText: true,
                      validator: (value) =>
                          passwordConfirmValidator(_passwordField.text, value),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 45,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: CustomColors.foliageGreen,
                    ),
                    child: MaterialButton(
                      onPressed: () => signUpButtonClick(() {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: CustomColors.trueWhite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Already have an account?',
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
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 18,
                          color: CustomColors.trueWhite,
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
