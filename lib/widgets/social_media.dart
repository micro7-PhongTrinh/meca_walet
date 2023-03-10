import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/bloc/application_setting/application_setting_bloc.dart';
import '../bloc/authentication/signin/google_signin_bloc.dart';
import '../constants/colors.dart';
import '../features/home/home_screen.dart';
import '../utils/screen_utils.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({
    super.key,
    required this.method,
  });

  final String method;

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
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
                getProportionateScreenWidth(4),
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: getProportionateScreenWidth(16),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(
              double.infinity,
              getProportionateScreenHeight(56),
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          // ElevatedButton(
          //   onPressed: () {},
          //   child: Text(
          //     '$method with Facebook',
          //   ),
          // ),
          // SizedBox(
          //   height: getProportionateScreenHeight(16),
          // ),
          const GoogleSignInButton(),
          SizedBox(
            height: getProportionateScreenHeight(32),
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
        context.read<ApplicationSettingBloc>().add(SaveUserLoggedinEvent());
        Navigator.of(context).pushNamed(IDHome.routeName);
      } else if (googleState.isSignedUpFailed) {}
    });
  }
}
