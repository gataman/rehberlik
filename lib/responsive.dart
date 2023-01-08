import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  static const int _mobileWidth = 501;
  static const int _desktopWidth = 900;

  const Responsive({Key? key, required this.mobile, this.tablet, required this.desktop}) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < _mobileWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < _desktopWidth && MediaQuery.of(context).size.width >= _mobileWidth;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= _desktopWidth;

  static double dialogWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < _mobileWidth) {
      return width * .8;
    } else {
      return width * .5;
    }
  }

  static double dialogHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return height * .5;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 1100) {
      return desktop;
    } else if (size.width >= 850 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
