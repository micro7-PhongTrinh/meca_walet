import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class SearchBar extends StatelessWidget {
  final String hint;

  const SearchBar(this.hint, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: kFillColorThird,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8),
          ),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8),
          ),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(
            10,
          ),
        ),
        hintStyle: TextStyle(
          color: kGreyShade2,
          fontSize: getProportionateScreenWidth(17),
        ),
      ),
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
