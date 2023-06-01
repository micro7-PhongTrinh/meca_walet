import 'package:flutter/material.dart';
import 'package:meca_service/data/product.dart';

class StoreProductCard extends StatelessWidget {
  const StoreProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              height: double.maxFinite,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                product.imgUrl,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => Container(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('45.000đ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          SizedBox(width: 5)
                        ],
                      ),
                    ],
                  )
                  // IconButton(
                  //     onPressed: () {},
                  //     color: kPrimaryPurple,
                  //     icon: SvgPicture.asset(
                  //       'assets/icons/plus_button.svg',
                  //       height: 36,
                  //       width: 36,
                  //       fit: BoxFit.fitWidth,
                  //     ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
