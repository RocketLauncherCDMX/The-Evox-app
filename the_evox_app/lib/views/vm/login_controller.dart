import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/auth_provider.dart';
import 'login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  final Ref ref;

  LoginController(this.ref) : super(const LoginStateInitial());

  void loginWithEmailAndPassword(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email, password);
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }

  void loginWithGoogle() async {
    state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
