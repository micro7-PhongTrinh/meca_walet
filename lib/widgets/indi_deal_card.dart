import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class IndiDealCard extends StatelessWidget {
  final bool isLeft;
  final bool isSelected;
  final bool noPadding;
  final Function addHandler;

  const IndiDealCard(
      {super.key,
      required this.isLeft,
      required this.isSelected,
      required this.addHandler,
      this.noPadding = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: !noPadding
          ? EdgeInsets.only(
              left: isLeft ? getProportionateScreenWidth(16.0) : 0,
              right: isLeft ? 0 : getProportionateScreenWidth(16.0),
            )
          : const EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(8.0),
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(
              8,
            ),
          ),
          boxShadow: [
            isSelected
                ? BoxShadow(
                    color: kShadowColor,
                    offset: Offset(
                      getProportionateScreenWidth(24),
                      getProportionateScreenWidth(40),
                    ),
                    blurRadius: 80,
                  )
                : const BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: kGreyShade5,
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dragon Fruit',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '200gr',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColorAccent,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$45',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () => addHandler,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: kPrimaryPurple,
                        constraints: BoxConstraints.tightFor(
                          width: getProportionateScreenWidth(
                            40,
                          ),
                          height: getProportionateScreenWidth(
                            40,
                          ),
                        ),
                        elevation: 0,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
