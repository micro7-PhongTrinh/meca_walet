import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/authentication/signin/google_signin_bloc.dart';
import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/option_button.dart';
import '../../widgets/or_row.dart';
import '../../widgets/social_media.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/loginScreen';

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return BlocProvider<GoogleSignupBloc>(
      create: (_) => GoogleSignupBloc(),
      child: _SigninBody(),
    );
  }
}

class _SigninBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BackButtonLS(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Log In Continue!',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SocialMediaLogin(
                    method: 'Login',
                  ),
                  const Spacer(),
                  const OrRow(),
                  const Spacer(),
                  const TextFields(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: kPrimaryPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('');
                    },
                    child: const Text('Login'),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  OptionButton(
                    desc: 'Don\'t have an account? ',
                    method: 'Sign Up',
                    onPressHandler: () {
                      Navigator.of(context).pushNamed('');
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class TextFields extends StatelessWidget {
  const TextFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomTextField(
          hint: 'Phone Number',
        ),
        // SizedBox(
        //   height: getProportionateScreenHeight(16),
        // ),
        // CustomTextField(
        //   hint: 'Password',
        //   icon: Image.asset('assets/images/hide_icon.png'),
        // ),
      ],
    );
  }
}