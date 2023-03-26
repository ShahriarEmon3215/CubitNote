import 'package:cubit_note/core/values/app_colors.dart';
import 'package:cubit_note/core/values/app_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../../core/values/text_styles.dart';
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
            child: Column(
              children: [
                _AppBar(context, themeController),
                AppValues.spaceH10,
                _BodyUi(context, themeController),
              ],
            ),
          ),
        ));
  }

  Widget _BodyUi(BuildContext context, ThemeController themeController) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: MediaQuery.of(context).size.height -
          (65 + MediaQuery.of(context).padding.top),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) =>
            _noteItemView(themeController, context),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 1.8 : 2.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }

  Widget _noteItemView(ThemeController themeController, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: themeController.isDarkTheme!
            ? AppColors.cardColorDark
            : AppColors.cardColorLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Note asdfsdf sdff asdfsdfg asdfsd",
            maxLines: 2,
            style: themeController.isDarkTheme!
                ? titleTextStyleDark
                : titleTextStyleLight,
          ),
          AppValues.spaceH10,
          Text(
            "02 FEB 2023",
            maxLines: 2,
            style: themeController.isDarkTheme!
                ? bodyTextStyleDark
                : bodyTextStyleLight,
          ),
          AppValues.spaceH10,
          Container(
            child: Text(
              "Note asdfsdf sdff asdfsdfg asdfsd asdfadsf asdfadsf asdfads asddfasdf asdfasd dfa fads a a dafads asdf asdfads fadsfasdf adsfadf s df",
              maxLines: 3,
              style: themeController.isDarkTheme!
                  ? bodyTextStyleDark
                  : bodyTextStyleLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _AppBar(BuildContext context, ThemeController themeController) {
    return Container(
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.list),
          ),
          Spacer(),
          Text(
            "Cubit Notes",
            style: themeController.isDarkTheme!
                ? appBarTextStyleDark
                : appBarTextStyleLight,
          ),
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
