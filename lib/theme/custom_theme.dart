import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_schemes.g.dart';

class CustomTheme {
  static ThemeData themeData(BuildContext context) {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ).apply(bodyColor: colorScheme.onBackground),
    )..appBarTheme.copyWith(
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.onBackground,
      );
  }
}
