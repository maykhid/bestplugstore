import 'package:flutter/material.dart';

class ScreenData {
  static MediaQueryData _mediaQueryData;
  static Orientation orientation;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double half;
  static double ten;
  static double five;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    orientation = _mediaQueryData.orientation;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    half = 2.0;
    five = 5.0;
    ten = 10.0;
  }
}
