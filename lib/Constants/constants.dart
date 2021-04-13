import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String appTitle = 'HackUST';
const int textPrimaryColor = 0xFF333333;
const int colorWhite = 0xFFFFFFFF;
const int backgroundPrimaryColor = 0xFFCAEDAF;

final TextStyle header1TextTheme = GoogleFonts.comfortaa(
  fontSize: 32,
  fontWeight: FontWeight.w500,
  color: const Color(0xFF1e1e1e),
);

final TextStyle header2TextTheme = GoogleFonts.comfortaa(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  color: const Color(0xFF1e1e1e),
);

final TextStyle body1TextTheme = GoogleFonts.comfortaa(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: const Color(0xFF1e1e1e),
);

final TextStyle body2TextTheme = GoogleFonts.comfortaa(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: const Color(0xFFFFFFFF),
);

double postArea = 0.52;
double imageArea = postArea * 0.88;
double locationrowArea = postArea * 0.12;
double usernameArea = postArea * 0.09;
