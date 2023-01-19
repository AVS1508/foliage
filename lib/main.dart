// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// Project imports:
import 'package:foliage/views/main/home_view.dart';
import 'constants/firebase_options.dart';
import 'constants/theme.dart';
import 'views/authentication/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      title: 'Foliage',
      theme: GlobalTheme.lightTheme,
      darkTheme: GlobalTheme.darkTheme,
      home: (user != null) ? const HomeView() : const LoginView(),
    );
  }
}
