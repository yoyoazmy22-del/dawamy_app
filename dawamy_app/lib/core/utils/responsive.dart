import 'package:flutter/material.dart';

class Responsive {
  static late BuildContext _context;
  static late MediaQueryData _mediaQuery;
  static late double _width;
  static late double _height;
  static late double _diagonal;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;

  static void init(BuildContext context) {
    _context = context;
    _mediaQuery = MediaQuery.of(context);
    _width = _mediaQuery.size.width;
    _height = _mediaQuery.size.height;
    _diagonal = (_width * _width + _height * _height) / 2;
    _blockSizeHorizontal = _width / 100;
    _blockSizeVertical = _height / 100;
  }

  static MediaQueryData get mediaQuery => _mediaQuery;

  static double get width => _width;
  static double get height => _height;

  static double get blockH => _blockSizeHorizontal;
  static double get blockV => _blockSizeVertical;

  static bool get isMobile => _width < 600;
  static bool get isTablet => _width >= 600 && _width < 1024;
  static bool get isDesktop => _width >= 1024;

  static double get textScaleFactor => _mediaQuery.textScaleFactor;

  static double wp(double percent) => _width * (percent / 100);
  static double hp(double percent) => _height * (percent / 100);

  static double sp(double size) {
    return size * (isMobile ? 1.0 : isTablet ? 1.2 : 1.4);
  }

  static EdgeInsets get safePadding => EdgeInsets.fromLTRB(
        blockH * 4,
        _mediaQuery.padding.top + blockV * 2,
        blockH * 4,
        _mediaQuery.padding.bottom + blockV * 2,
      );
}
