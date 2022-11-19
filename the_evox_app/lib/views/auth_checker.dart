import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/providers/auth_provider.dart';
import 'package:the_evox_app/views/screens/screens.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
        data: (user) {
          if (user != null) return const MyHome();
          return const Tours01();
        },
        loading: (() => const CircularProgressIndicator()),
        error: (e, trace) => const LoginForm());
  }
}
