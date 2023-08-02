import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone/states/auth/constant/constant.dart';
import 'package:instagram_clone/states/auth/model/auth_result.dart';
import 'package:instagram_clone/states/post/typedefs/user_id.dart';

class Authenticator {
  const Authenticator();
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? "";
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oauthCrendential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(
        oauthCrendential,
      );
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
