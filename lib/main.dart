import 'package:cubit_note/modules/home/views/home_screen.dart';
import 'package:cubit_note/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDarkMode = prefs.getBool('darkMode') ?? false;
    runApp(
      ChangeNotifierProvider<ThemeController>(
        create: (_) => ThemeController(isDarkTheme: isDarkMode),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getThemeData,
      home: HomeScreen(),
    );
  }
}
