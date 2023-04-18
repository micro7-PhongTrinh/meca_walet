import 'package:flutter/material.dart';

import '../../constants/colors.dart';

///best practices
import 'intro_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/landing.png',
                fit: BoxFit.cover,
                color: kPrimaryPurple,
              ),
            ),
            _IntroWidget()
          ],
        ),
      ),
    );
  }
}

class _IntroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Welcome to Meca Wallet',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
            Text(
              'We have more than 10,000+ food available for all of you.',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: kTextColorAccent,
                  ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(IntroScreen.routeName);
              },
              child: const Text('Get Started'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
