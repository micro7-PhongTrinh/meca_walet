import 'package:flutter/material.dart';
import '../../../model/featured_product.dart';

class StoreProductCard extends StatelessWidget {
  const StoreProductCard({super.key, required this.featuredProduct});
  final FeaturedProductModel featuredProduct;
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
          Container(
            height: double.maxFinite,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              featuredProduct.product.imgUrl,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => Container(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(featuredProduct.product.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('45.000đ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            featuredProduct.product.ratePoint.toString(),
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.grey.shade600),
                          )
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
