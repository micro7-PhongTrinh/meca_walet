import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';

class SuggestItem extends StatelessWidget {
  const SuggestItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: Row(
          children: [
            Container(
                width: 60,
                decoration: ShapeDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(
                            'https://duhocsunny.edu.vn/wp-content/uploads/2020/05/4-tiem-tra-sua-khuay-dao-gioi-tre-han-quoc-3.jpg')),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ))),
            const SizedBox(width: 15),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Trà sữa dưa lưới',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryPurple,
                          overflow: TextOverflow.ellipsis)),
                  Text('45 thành viên - 4 Phạm Ngọc Thạch, Tân Phú, Quận 9',
                      style: TextStyle(fontSize: 16, color: kTextColorThird),
                      overflow: TextOverflow.ellipsis)
                ],
              ),
            )
          ],
        ));
  }
}
