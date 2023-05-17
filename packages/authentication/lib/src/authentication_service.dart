import 'package:google_sign_in/google_sign_in.dart';
import 'package:meca_service/meca_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_exception.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final MecaService _mecaService;
  User? _user;

  User? get user => _user;

  AuthenticationService({GoogleSignIn? googleSignIn, MecaService? mecaService})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _mecaService = mecaService ?? MecaService();

  Future<User> signinGoogle() async {
    GoogleSignInAccount? account;
    try {
      account = await _googleSignIn.signIn();
    } catch (e) {
      throw AuthenticationFailedException.otherError();
    }
    if (account == null) throw AuthenticationFailedException.userCanceled();

    //get GG account credential to sign in firebase

    await _signInMecaServer(account);

    return getCurrentUser();
  }

  Future signoutGoogle() async {
    if (_user == null) return;
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (e) {
      throw (Exception(e));
    }
  }

  // For whether user login or not
  Future<User> checkLoggedInUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var jwt = localStorage.getString('jwt');
    if (jwt != null) {
      GoogleSignInAccount? account = await GoogleSignIn().signInSilently();
      if (account == null) throw AuthenticationFailedException.userNotFound();
      await _signInMecaServer(account);
    }

    return getCurrentUser();
  }

  Future<void> _signInMecaServer(GoogleSignInAccount account) async {
    final GoogleSignInAuthentication googleAuth = await account.authentication;

    try {
      _user = await _mecaService.authWithGoogle(googleAuth.accessToken!);
      print('accessToken: ' + googleAuth.accessToken!);
    } catch (e) {
      throw AuthenticationFailedException.otherError();
    }
  }

  User getCurrentUser() {
    if (_user == null) throw AuthenticationException('User not found');
    return _user!;
  }
}
