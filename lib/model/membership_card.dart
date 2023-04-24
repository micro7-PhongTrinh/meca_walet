import 'dart:math';
import 'dart:ui';

import '../constants/colors.dart';

class MembershipCardModel {
  final String name;
  final String imageUrl;
  final String ownerName;
  final int openDate;
  final int openMonth;
  late Color? cardColor;

  MembershipCardModel(
      this.name, this.imageUrl, this.ownerName, this.openDate, this.openMonth,
      {this.cardColor}) {
    cardColor = cardColor ??
        cardColors[Random().nextInt(100) % (cardColors.length - 1)];
  }
}
