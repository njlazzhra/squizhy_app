import 'dart:math';
import 'package:flutter/material.dart';

const double kMaxContentWidth = 600;

extension ResponsiveContext on BuildContext {
  /// percentage dari lebar konten (maksimal 600 supaya tidak melebar di web/tablet).
  double w(double fraction) =>
      min(MediaQuery.sizeOf(this).width, kMaxContentWidth) * fraction;

  /// percentage dari tinggi layar.
  double h(double fraction) => MediaQuery.sizeOf(this).height * fraction;
}