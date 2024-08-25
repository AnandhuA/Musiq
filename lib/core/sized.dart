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


//----------------height--------------
const constHeight3 = SizedBox(height: 3);
const constHeight5 = SizedBox(height: 5);
const constHeight10 = SizedBox(height: 10);
const constHeight20 = SizedBox(height: 20);
const constHeight30 = SizedBox(height: 30);
const constHeight40 = SizedBox(height: 40);
const constHeight50 = SizedBox(height: 50);

//------------------width--------------

const constWidth5 = SizedBox(width: 5);
const constWidth10 = SizedBox(width: 10);
const constWidth20 = SizedBox(width: 20);
const constWidth30 = SizedBox(width: 30);
const constWidth40 = SizedBox(width: 40);
const constWidth50 = SizedBox(width: 50);
