import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class RandomCardColor {
   Color generateRandomCardColor =
      cardColors[Random().nextInt(100) % (cardColors.length - 1)];
}
