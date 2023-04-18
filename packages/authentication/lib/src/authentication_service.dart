import 'package:authentication/src/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication_exception.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  late UserModel _user = UserModel.empty;

  AuthenticationService(
      {GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      _user =
          firebaseUser == null ? UserModel.empty : toUserModel(firebaseUser);
      return _user;
    });
  }

  UserModel get currentUser {
    return _user;
  }

  Future<UserModel> signinGoogle() async {
    GoogleSignInAccount? account;
    try {
      account = await _googleSignIn.signIn();
    } catch (e) {
      throw AuthenticationFailedException.otherError();
    }
    if (account == null) throw AuthenticationFailedException.userCanceled();

    //get GG account credential to sign in firebase

    final OAuthCredential oAuthCredential =
        await _getCredentialFromAccount(account);

    await _signInFirebase(oAuthCredential);

    return await getCurrentUser();
  }

  Future signoutGoogle() async {
    if (_firebaseAuth.currentUser == null) return;
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      _firebaseAuth.signOut();
    } catch (e) {
      throw (Exception(e));
    }
  }

  Future<UserModel> getCurrentUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw AuthenticationFailedException.userNotFound();
    }
    return toUserModel(firebaseUser);
  }

  UserModel toUserModel(User user) {
    return UserModel(
        name: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        avatarUrl: user.photoURL);
  }

  Future<OAuthCredential> _getCredentialFromAccount(
      GoogleSignInAccount account) async {
    final GoogleSignInAuthentication googleAuth = await account.authentication;
    return GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  }

  Future<void> _signInFirebase(AuthCredential oAuthCredential) async {
    try {
      await _firebaseAuth.signInWithCredential(oAuthCredential);
    } catch (e) {
      throw AuthenticationFailedException.otherError();
    }
  }
}
