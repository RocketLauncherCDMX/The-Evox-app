import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/views/screens/repotesting_screen.dart';
import 'package:the_evox_app/views/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_evox_app/views/auth_checker.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: TheEvox()));
}

class TheEvox extends StatelessWidget {
  const TheEvox({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Evox',
        home: const RepotestingScreen(),
        routes: {
          'login': (_) => const LoginForm(),
          'register': (_) => const RegisterForm(),
          'home': (_) => const MyHome(),
          'tour': (_) => const Tours01(),
        });
  }
}
