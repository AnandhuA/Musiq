import 'package:flutter/material.dart';

class ScreenBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
}

bool isMobile(BuildContext context) =>
    MediaQuery.of(context).size.width < ScreenBreakpoints.mobile;

bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= ScreenBreakpoints.mobile &&
    MediaQuery.of(context).size.width < ScreenBreakpoints.tablet;

bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= ScreenBreakpoints.tablet;



class AppSpacing {
  // Height constants
  static const SizedBox height3 = SizedBox(height: 3);
  static const SizedBox height5 = SizedBox(height: 5);
  static const SizedBox height10 = SizedBox(height: 10);
  static const SizedBox height20 = SizedBox(height: 20);
  static const SizedBox height30 = SizedBox(height: 30);
  static const SizedBox height40 = SizedBox(height: 40);
  static const SizedBox height50 = SizedBox(height: 50);

  // Width constants
  static const SizedBox width5 = SizedBox(width: 5);
  static const SizedBox width10 = SizedBox(width: 10);
  static const SizedBox width20 = SizedBox(width: 20);
  static const SizedBox width30 = SizedBox(width: 30);
  static const SizedBox width40 = SizedBox(width: 40);
  static const SizedBox width50 = SizedBox(width: 50);
}
