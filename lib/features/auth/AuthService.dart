import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // User canceled sign-in

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      // Check if the email ends with "@iitpkd.ac.in"
      if (user != null && user.email != null) {
        if (user.email!.endsWith("iitpkd.ac.in")) {
          return userCredential; // Allow sign-in
        } else {
          await signout(); // Sign out unauthorized users
          return null;
        }
      }
    } catch (e) {
      print("Error during Google Sign-In: $e");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
