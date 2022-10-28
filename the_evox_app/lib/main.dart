import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_evox_app/User/bloc/user_bloc.dart';
import 'package:the_evox_app/screens.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TheEvox());
}

class TheEvox extends StatelessWidget {
  const TheEvox({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => UserBloc())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Evox',
          home: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return state.isLogged ? const MyHome() : const Tours01();
            },
          ),
          routes: {
            'login': (_) => const LoginForm(),
            'register': (_) => const RegisterForm(),
            'home': (_) => const MyHome(),
            'tour': (_) => const Tours01(),
          }),
    );
  }
}
