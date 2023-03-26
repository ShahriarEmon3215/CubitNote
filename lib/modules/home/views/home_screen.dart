import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/theme/theme_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            child: Column(
              children: [
                _AppBar(context, themeController),
              ],
            ),
          ),
        ));
  }

  Widget _AppBar(BuildContext context, ThemeController themeController) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          _kDarkModeButton(themeController),
        ],
      ),
    );
  }

  Widget _kDarkModeButton(ThemeController themeController) {
    return InkWell(
      onTap: () async {
        themeController.setThemeData = themeController.isDarkTheme!;
        var prefs = await SharedPreferences.getInstance();
        await prefs.setBool('darkMode', themeController.isDarkTheme!);
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: themeController.isDarkTheme! ? Colors.white : Colors.black,
        ),
        child: Center(
          child: Icon(
            themeController.isDarkTheme! ? Icons.dark_mode : Icons.sunny,
            color: themeController.isDarkTheme! ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
