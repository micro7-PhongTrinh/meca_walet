import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/authentication/signin/google_signin_bloc.dart';
import '../constants/colors.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({
    super.key,
    required this.method,
  });

  final String method;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
      data: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            kAccentPurple,
          ),
          foregroundColor: MaterialStateProperty.all(
            kPrimaryPurple,
          ),
          elevation: MaterialStateProperty.all(
            0,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 16,
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            const Size(
              double.infinity,
              56,
            ),
          ),
        ),
      ),
      child: Column(
        children: const [
          // ElevatedButton(
          //   onPressed: () {},
          //   child: Text(
          //     '$method with Facebook',
          //   ),
          // ),
          // SizedBox(
          //   height: getProportionateScreenHeight(16),
          // ),
          GoogleSignInButton(),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleSignupBloc, GoogleSignupState>(
        builder: (BuildContext stateContext, GoogleSignupState googleState) {
      return ElevatedButton(
        onPressed: () {
          context.read<GoogleSignupBloc>().add(SignUpByGoogleEvent());
        },
        child: const Text(
          'Sign in with Google',
        ),
      );
    }, listener: (BuildContext stateContext, GoogleSignupState googleState) {
      if (googleState.isSignedUpSucceed) {
      } else if (googleState.isSignedUpFailed) {}
    });
  }
}
