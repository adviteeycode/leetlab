import 'package:flutter/material.dart';
import 'package:leetlab/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: themeProvider.toggleTheme,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: (themeProvider.isDarkTheme)
              ? Icon(Icons.light_mode)
              : Icon(Icons.dark_mode_rounded),
        ),
      ),
    );
  }
}
