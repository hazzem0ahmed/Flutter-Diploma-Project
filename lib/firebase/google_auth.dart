import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth/data/datasource/contract/auth_local_datasource.dart';
import '../di/modules/service_locator.dart';

class FirebaseAuthServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthLocalDatasource _localDatasource = getIt<AuthLocalDatasource>();

  static User? get user => FirebaseAuth.instance.currentUser;

  Future<User?> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> signOutGoogle() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> deleteGoogleAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("No user is currently signed in.");
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Re-authentication cancelled.");
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await user.reauthenticateWithCredential(credential);

      await user.delete();

      await _localDatasource.clearToken();
    } on FirebaseAuthException catch (e) {
      throw Exception(
        "Failed to delete account. Please try again. Error: ${e.code}",
      );
    } catch (e) {
      throw Exception("An unexpected error occurred.");
    }
  }
}
