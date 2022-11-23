import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/models/user_profile_model.dart';
import 'package:the_evox_app/repositories/auth_repository.dart';
import 'package:the_evox_app/repositories/user_profile_repository.dart';
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

  Future<User?> loginWithGoogle() async {
    state = const LoginStateLoading();
    try {
      final signedUser =
          await ref.read(authRepositoryProvider).signInWithGoogle();

      UserProfileRepository profileProvider = UserProfileRepository();
      UserProfile? signedProfile = await profileProvider
          .getUserProfileByAuthId(signedUser!.uid.toString());

      if (profileProvider.status == true) {
        //user has profile

      } else {
        UserProfile newUserProfile = UserProfile(
            userId: signedUser.uid,
            name: signedUser.displayName.toString(),
            email: signedUser.email.toString(),
            photo: signedUser.photoURL.toString(),
            countryCode: null,
            verified: true);
        newUserProfile.profileDocId =
            await profileProvider.createUserProfile(newUserProfile);

        if (profileProvider.status == true) {
          signedProfile = newUserProfile;
        } else {
          // Error
          print(profileProvider.errorMessage);
        }
      }

      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
      print(state);
    }
    return null;
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
