import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode theme = ThemeMode.light;

  void setMode(bool isDark) {
    theme = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool isDark() => theme == ThemeMode.dark;
  void changeMode() {
    theme = (theme == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;

    notifyListeners();
  }
}

class AppThemes {
  static final darkTheam = ThemeData(
    primaryColor: Colors.blue.shade900,
    scaffoldBackgroundColor: Colors.grey.shade900,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.blue.shade900,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      selectedIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      unselectedIconTheme: const IconThemeData(color: Colors.white70),
    ),
    dividerColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: Colors.orange.shade900,
    ),
  );

  static final lightTheam = ThemeData(
    primaryColor: Colors.lightBlue.shade300,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.blue.shade300,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.black54,
      selectedIconTheme: const IconThemeData(color: Colors.black87),
      unselectedIconTheme: const IconThemeData(color: Colors.black54),
    ),
    dividerColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    ).copyWith(
      secondary: Colors.orange.shade400,
    ),
  );
}
