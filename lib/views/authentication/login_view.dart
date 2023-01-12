import 'package:crypto_wallet/api/flutterfire.dart';
import 'package:flutter/material.dart';

import '../home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  void logInButtonClick(VoidCallback onSuccess) async {
    bool shouldNavigate = await signIn(_emailField.text, _passwordField.text);
    if (shouldNavigate) {
      onSuccess.call();
    }
  }

  void signUpButtonClick(VoidCallback onSuccess) async {
    bool shouldNavigate = await register(_emailField.text, _passwordField.text);
    if (shouldNavigate) {
      onSuccess.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 4,
                  child: const Image(
                    image: AssetImage('lib/assets/icons/icon_transparent.png'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
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
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 35),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
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
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.blueAccent,
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
                        child: const Text('Log In'),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
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
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
