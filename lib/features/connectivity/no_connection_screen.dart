import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/no_connection.svg',
            fit: BoxFit.fitWidth,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Whoops!',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: const Color(0xFF1C2025)),
                ),
                Text(
                  'Slow or no internet connections.\nPlease check your internet settings',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: const Color(0xFF1C2025)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
