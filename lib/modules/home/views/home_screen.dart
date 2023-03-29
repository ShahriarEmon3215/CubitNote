import 'package:cubit_note/core/values/app_colors.dart';
import 'package:cubit_note/core/values/app_values.dart';
import 'package:cubit_note/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../../core/values/text_styles.dart';
import '../../../models/note.dart';
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
    return Consumer<NoteController>(
      builder: (BuildContext context, controller, Widget? child) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: controller.notes.length,
              itemBuilder: (BuildContext context, int index) => _noteItemView(
                  themeController, context, controller.notes[index]),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 1.5 : 1.7),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          ),
        );
      },
    );
  }

  Widget _noteItemView(
      ThemeController themeController, BuildContext context, Note note) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/note-view');
      },
      child: Container(
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
              note.title ?? "No Title",
              maxLines: 2,
              style: titleTextStyle(themeController.isDarkTheme!),
            ),
            AppValues.spaceH10,
            Text(
              "02 FEB 2023",
              maxLines: 2,
              style: dateColor(themeController.isDarkTheme!),
            ),
            AppValues.spaceH10,
            Container(
              child: Text(
                note.body ?? "",
                maxLines: 3,
                style: bodyTextStyle(themeController.isDarkTheme!),
              ),
            ),
          ],
        ),
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
            style: appBarTextStyle(themeController.isDarkTheme!),
          ),
          Spacer(),
          //_kDarkModeButton(themeController),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/note-view');
              },
              icon: Icon(Icons.add))
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
