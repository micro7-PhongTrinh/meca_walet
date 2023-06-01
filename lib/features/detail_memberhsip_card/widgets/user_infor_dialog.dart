import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meca_service/data/detail_member_card.dart';
import 'package:meca_service/meca_service.dart';
import 'package:meca_wallet/bloc/authentication/authentication/authentication_bloc.dart';
import 'package:meca_wallet/constants/colors.dart';

class UserCardInforDialog extends StatelessWidget {
  const UserCardInforDialog({super.key, required this.detailCard});

  final DetailMemberCard detailCard;

  @override
  Widget build(BuildContext context) {
    final User user = BlocProvider.of<AuthenticationBloc>(context).user!;
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
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Text('Thành viên:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor))),
                        Expanded(
                            flex: 1,
                            child: Text(user.userName,
                                style: const TextStyle(
                                    fontSize: 16, color: kTextColorAccent)))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Text('Ngày mở:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor))),
                        Expanded(
                            flex: 1,
                            child: Text(
                                DateFormat('dd-MM-yyyy')
                                    .format(detailCard.openDate),
                                style: const TextStyle(
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
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text('Email:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor)),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(user.email,
                                style: const TextStyle(
                                    fontSize: 16, color: kTextColorAccent)))
                      ],
                    )
                  ],
                ),
              ],
            )));
  }
}
