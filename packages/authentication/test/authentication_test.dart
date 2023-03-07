import 'package:authentication/src/authentication_exception.dart';
import 'package:authentication/src/authentication_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

import 'authentication_test.mocks.dart';

@GenerateMocks([GoogleSignIn, FirebaseAuth])
void main() {
  final GoogleSignIn googleSignIn = MockGoogleSignIn();
  final FirebaseAuth firebaseAuth = MockFirebaseAuth();
  final AuthenticationService authenticationService = AuthenticationService(
      googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

  //Khong test successfull sign in vi cai nay package da test roi

  //I had a new idea, that is generate for gg account, and pass it to the mock method above
  group('test user cancel sign in process flow', () {
    test('test sign in process was canceled then ...', () {
      when(googleSignIn.signIn())
          .thenAnswer((realInvocation) => Future.value(null));

      expect(() => authenticationService.signinGoogle(),
          throwsA(isA<AuthenticationFailedException>()));
    });

    test('test sign in process was canceled then ...', () {
      when(googleSignIn.signIn()).thenAnswer((realInvocation) =>
          throw PlatformException(code: 'sign_in_canceled'));

      expect(() => authenticationService.signinGoogle(),
          throwsA(isA<AuthenticationFailedException>()));
    });
  });

  group('test failed sign in process', () {
    test(
        'test sign in process was failed then will throw error with detail error code',
        () {
      when(googleSignIn.signIn()).thenAnswer(
          (realInvocation) => throw PlatformException(code: 'sign_in_failed'));

      expect(() => authenticationService.signinGoogle(),
          throwsA(isA<AuthenticationFailedException>()));
    });

    group('when user already login Google account, but firebase auth exception',
        () {
      test(
          'Firebase could not find user by my Id access token then throw Error',
          () {
        when(firebaseAuth.signInWithCredential).thenAnswer((realInvocation) =>
            throw FirebaseAuthException(code: 'user-not-found'));
        expect(() => authenticationService.signinGoogle(),
            throwsA(isA<AuthenticationFailedException>()));
      });

      test('My Google account has not able to authenticate by Firebase', () {
        when(firebaseAuth.signInWithCredential).thenAnswer((realInvocation) =>
            throw FirebaseAuthException(code: 'user-disabled'));
        expect(() => authenticationService.signinGoogle(),
            throwsA(isA<AuthenticationFailedException>()));
      });
    });
  });
}
