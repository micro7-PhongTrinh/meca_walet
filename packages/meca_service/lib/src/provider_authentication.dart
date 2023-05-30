import 'package:google_sign_in/google_sign_in.dart';
import 'package:meca_service/meca_service.dart';
import 'package:meca_service/src/meca_service_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_exception.dart';

class ProviderAuthentication {
  final GoogleSignIn _googleSignIn;

  ProviderAuthentication(
      {GoogleSignIn? googleSignIn, MecaServiceRequest? mecaService})
      : _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<String> signinGoogle() async {
    GoogleSignInAccount? account;
    try {
      account = await _googleSignIn.signIn();
    } catch (e) {
      throw AuthenticationFailedException.otherError();
    }
    if (account == null) throw AuthenticationFailedException.userCanceled();

    return getGoogleAccessToken(account);
  }

  Future<String> getGoogleAccessToken(GoogleSignInAccount account) async {
    final GoogleSignInAuthentication googleAuth = await account.authentication;

    return googleAuth.accessToken!;
  }

  Future signoutGoogle() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (e) {
      throw (Exception(e));
    }
  }

  Future<String> signinSilentlyGoogle() async {
    GoogleSignInAccount? account;
    try {
      account = await _googleSignIn.signInSilently();
    } catch (e) {
      throw AuthenticationFailedException.otherError();
    }
    if (account == null) throw AuthenticationFailedException.userCanceled();

    return getGoogleAccessToken(account);
  }
}
