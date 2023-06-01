import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/features/store/bloc/get_memcard_cubit.dart';

import '../../../constants/colors.dart';
import '../store_screen.dart';

class IntegrateMembershipDialog extends StatelessWidget {
  const IntegrateMembershipDialog({super.key, required this.onSubmit});

  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 144,
              width: 144,
              child: Image.asset(
                fit: BoxFit.fill,
                'assets/images/adding-card.png',
                color: kPrimaryPurple,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Mở thẻ thành viên',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                    fontSize: 20)),
            const SizedBox(height: 20),
            const Text(
                'Mở thẻ thành viên tại quán, bạn có thể nhận thêm ưu đãi và đặc quyền cho khách hàng thân thiết tại quán. \n\nBạn có muốn tiếp tục?',
                style: TextStyle(
                    color: kTextColorAccent, height: 1.4, fontSize: 16),
                textAlign: TextAlign.center),
            const SizedBox(height: 35),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  onSubmit();
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ]),
          ],
        ),
      ),
    );
    ;
  }
}
