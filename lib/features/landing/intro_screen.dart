import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../login/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/introScreen';

  const IntroScreen({super.key});

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  int pageCount = 0;

  final PageController _controller = PageController();

  void setPageCount(int aPageCount) {
    setState(() {
      pageCount = aPageCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: Column(
        children: [
          IllustrationPageView(_controller, setPageCount),
          _TextView(pageCount),
        ],
      ),
    );
  }
}

class _TextView extends StatelessWidget {
  final int pageCount;

  const _TextView(this.pageCount);
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {
        'title': 'Everything You Need',
        'desc':
            'Vegetables that are directly picked by farmers and guaranteed quality and freshness',
      },
      {
        'title': 'Easy Intergation',
        'desc':
            'Grab your items only need to order from home, click pay and wait for the courier to arrive',
      },
      {
        'title': 'Fast Operation',
        'desc':
            'Courier will send the groceries you buy in just 1 day, very fast like a flash!',
      },
    ];
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            const Spacer(),
            Text(
              data[pageCount]['title']!,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: kTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            Text(
              data[pageCount]['desc']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextColorAccent,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PageIndicator(pageCount, 0),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                _PageIndicator(pageCount, 1),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                _PageIndicator(pageCount, 2),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              child: const Text(
                'Get Started',
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator(this.pageCount, this.index);

  final int pageCount;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      width: pageCount == index
          ? getProportionateScreenWidth(32)
          : getProportionateScreenWidth(8),
      height: getProportionateScreenWidth(8),
      decoration: BoxDecoration(
        color: pageCount == index ? kPrimaryPurple : kFillColorPrimary,
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(4),
        ),
      ),
    );
  }
}

class IllustrationPageView extends StatelessWidget {
  final PageController controller;
  final Function(int) callback;

  const IllustrationPageView(this.controller, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        color: kAccentPurple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: kTextColor,
                        ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(20),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (pageNum) {
                  callback(pageNum);
                },
                children: [
                  Image.asset(
                    'assets/images/illu1.png',
                  ),
                  Image.asset(
                    'assets/images/illu2.png',
                  ),
                  Image.asset(
                    'assets/images/illu3.png',
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
          ],
        ),
      ),
    );
  }
}
