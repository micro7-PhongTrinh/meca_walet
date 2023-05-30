import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../widgets/tab_title.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: const Column(
          children:  [
            TabTitle(
              title: 'Hoạt động gần đây',
              padding: 0,
            ),
            SizedBox(height: 10),
            _ListTransaction()
          ],
        ));
  }
}

class _ListTransaction extends StatelessWidget {
  const _ListTransaction();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            4,
            ((index) => Container(
                decoration: const BoxDecoration(
                    color: kFillColorThird,
                    borderRadius: BorderRadius.all(Radius.circular(
                            10.0) //                 <--- border radius here
                        )),
                height: 68,
                margin: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: Container(),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Mở thẻ thành công',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: kTextColor)),
                            Text('17/04/2022',
                                style: TextStyle(
                                    height: 1.6, color: kTextColorAccent))
                          ],
                        )),
                    const SizedBox(width: 10),
                    const Expanded(
                        flex: 1,
                        child: Text('+1',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: kTextColor)))
                  ],
                )))));
  }
}
