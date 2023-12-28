import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ColorScheme get colorScheme {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFFFA7407),
      primary: const Color(0xFFF07109),
      secondary: const Color(0xFFF8AC6D),
      tertiary: const Color(0xFFFFD971),
    );
  }

  static ThemeData themeData(BuildContext context) {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: colorScheme.onBackground),
    );
  }
}
