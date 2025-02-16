import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testflow/utils/palette.dart';

class Style {
  static const String FONT_NAME = 'Outfit';

  static ThemeData themeData() => ThemeData(
    fontFamily: 'Outfit',
    colorSchemeSeed: Palette.primary,
    useMaterial3: true,
    scaffoldBackgroundColor: Palette.backgroundPane,
    textTheme: GoogleFonts.outfitTextTheme(),
  );

  static TextStyle textStyle({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
  }) => GoogleFonts.outfit(
    color: color,
    fontSize: size,
    fontWeight: weight,
    textStyle: TextStyle(overflow: overflow),
  );
}
