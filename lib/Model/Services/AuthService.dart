import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsaty/Model/DataModels/User.dart';

class AuthService {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isSignedIn(String uid) async {
    final res = await _auth.currentUser();
    return res.uid == uid;
  }

  Future<User> signIn() async {
    final GoogleSignInAccount res = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googlAuth = await res.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googlAuth.idToken, accessToken: googlAuth.accessToken);
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    return User(uid: user.uid, name: user.displayName, photoUrl: user.photoUrl);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
