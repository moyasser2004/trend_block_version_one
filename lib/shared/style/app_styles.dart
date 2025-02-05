import 'package:flutter/material.dart';

abstract class AppStyles {
  static const TextStyle styleSemiBold21 = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
  );

  static TextStyle styleNormal16 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle styleBold16 = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle styleBold18 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle styleBold12 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  static TextStyle styleBold28 = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle styleNormal13 = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static TextStyle styleNormal11 = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}

// /// Thin, the least thick.
// static const FontWeight w100 = FontWeight._(0, 100);

// /// Extra-light.
// static const FontWeight w200 = FontWeight._(1, 200);

// /// Light.
// static const FontWeight w300 = FontWeight._(2, 300);

// /// Normal / regular / plain.
// static const FontWeight w400 = FontWeight._(3, 400);

// /// Medium.
// static const FontWeight w500 = FontWeight._(4, 500);

// /// Semi-bold.
// static const FontWeight w600 = FontWeight._(5, 600);

// /// Bold.
// static const FontWeight w700 = FontWeight._(6, 700);

// /// Extra-bold.
// static const FontWeight w800 = FontWeight._(7, 800);

// /// Black, the most thick.
// static const FontWeight w900 = FontWeight._(8, 900);

// /// The default font weight.
// static const FontWeight normal = w400;

// /// A commonly used font weight that is heavier than normal.
// static const FontWeight bold = w700;
