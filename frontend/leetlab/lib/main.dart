import 'package:flutter/material.dart';
import 'package:leetlab/util/app_theme.dart';
import 'package:leetlab/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'providers/problem_list_provider.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProblemListProvider()),
      ],
      child: const LeetLab(),
    ),
  );
}

class LeetLab extends StatelessWidget {
  const LeetLab({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'LeetLab',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.theme,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
