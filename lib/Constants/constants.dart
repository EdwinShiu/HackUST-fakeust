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
  fontWeight: FontWeight.w500,
  color: const Color(0xFFFFFFFF),
);

double postArea = 0.57;
double imageArea = postArea * 0.81;
double infocolArea = postArea * 0.19;

Map<String, int> tagColor = {
  "Exciting": 0xFFFF6868,
  "Artistic": 0xFF68E51C,
  "Thrilling": 0xFF2B50AA,
  "Beautiful": 0xFFFF9FE5,
  "Magnificent": 0xFFFFD4D4,
  "Spectacular": 0xFFFF858D,
  "Vintage": 0xFFC93F44,
  "Nostalgic": 0xFFC13EC9,
  "Breathtaking": 0xFFAB3EC9,
  "Adventurous": 0xFF3E78C9,
  "Wonderful": 0xFF40C9AB,
  "Dazzling": 0xFF67DEC8,
  "Delightful": 0xFFDEC868,
  "Exquisite": 0xFF66B6DE,
  "Splendid": 0xFFECE62B,
};
