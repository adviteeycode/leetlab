import 'package:flutter/material.dart';

double getResponsivePadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width > 900) return width * .2;
  if (width > 600) return width * .18;
  if (width > 400) return width * .15;
  return width * .1;
}

ThemeData get darkTheme {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    // scaffoldBackgroundColor: const Color(0xFF0E0E0E),
    splashColor: const Color(0xFF2C2C2C),
    primaryColor: Colors.white70,
    primaryColorDark: Colors.white,
    primaryColorLight: Colors.white38,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00E676),
      secondary: Color(0xFF00C853),
      surface: Color(0xFF1E1E1E),
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      surfaceTint: Colors.transparent,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white70),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: const Color.fromARGB(179, 129, 128, 128),
          width: .5,
        ),
      ),
    ),
    textTheme: const TextTheme(
      // 🧭 Display Styles — for big headings or hero text
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 1.1,
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),

      // 🏷️ Headline Styles — section titles, cards, or UI headers
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFFEEEEEE),
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFFDDDDDD),
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFFCCCCCC),
      ),

      // 📚 Titles — smaller UI titles or buttons
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFFB3B3B3),
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xFFAAAAAA),
      ),

      // 📄 Body — paragraphs, normal UI text
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFFE0E0E0),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFB3B3B3),
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9E9E9E),
      ),

      // 💬 Labels — chips, buttons, or captions
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF00E676),
      ),
      labelMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFFB3B3B3),
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF888888),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      hintStyle: const TextStyle(color: Color(0xFFB3B3B3)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00E676),
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
    dividerColor: const Color(0xFF2A2A2A),
  );
}

ThemeData get lightTheme {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    // scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    splashColor: const Color.fromARGB(255, 212, 209, 209),
    primaryColor: Colors.black54,
    primaryColorLight: Colors.black38,
    primaryColorDark: Colors.black,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF00C853),
      secondary: Color(0xFF00E676),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      surfaceTint: Colors.transparent,
    ),

    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black54),
      titleTextStyle: TextStyle(
        color: Colors.black54,
        fontSize: 23,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      // margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: .5),
      ),
      shadowColor: Colors.grey.shade200,
      // elevation: 1,
    ),

    textTheme: const TextTheme(
      // 🧭 Display Styles — large headings (for dashboards or titles)
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: 1.1,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF222222),
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF333333),
      ),

      // 🏷️ Headline Styles — section headers or cards
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF222222),
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF333333),
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF444444),
      ),

      // 📚 Titles
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF444444),
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xFF666666),
      ),

      // 📄 Body
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF444444),
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color(0xFF666666),
      ),

      // 💬 Labels
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF00C853),
      ),
      labelMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF555555),
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF777777),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF9F9F9),
      hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00C853),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(const Color(0xFF00C853)),
      trackColor: WidgetStateProperty.all(const Color(0xFFB2DFDB)),
    ),

    iconTheme: const IconThemeData(color: Colors.black54),

    dividerColor: const Color(0xFFE0E0E0),
  );
}
