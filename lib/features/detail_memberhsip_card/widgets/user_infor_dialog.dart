import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';

class UserInforDialog extends StatelessWidget {
  const UserInforDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        insetAnimationDuration: const Duration(seconds: 1),
        insetPadding: EdgeInsets.zero,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(
                      10.0) //                 <--- border radius here
                  ),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    const Text('Thông tin thẻ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kTextColorAccent)),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Expanded(
                            flex: 1,
                            child: Text('Thành viên:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor))),
                        Expanded(
                            flex: 1,
                            child: Text('Trinhh Quoc Phong',
                                style: TextStyle(
                                    fontSize: 16, color: kTextColorAccent)))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Expanded(
                            flex: 1,
                            child: Text('Ngày mở:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor))),
                        Expanded(
                            flex: 1,
                            child: Text('14/02/2023',
                                style: TextStyle(
                                    fontSize: 16, color: kTextColorAccent)))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 45),
                Column(
                  children: [
                    const Text('Thông tin liên lạc',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kTextColorAccent)),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          flex: 1,
                          child: Text('Email:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor)),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text('trinhquocphong.vnag@gmail.com',
                                style: TextStyle(
                                    fontSize: 16, color: kTextColorAccent)))
                      ],
                    )
                  ],
                ),
              ],
            )));
  }
}
