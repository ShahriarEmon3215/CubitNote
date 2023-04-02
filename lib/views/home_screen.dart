import 'package:cubit_note/core/values/app_colors.dart';
import 'package:cubit_note/core/values/app_values.dart';
import 'package:cubit_note/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../core/helpers/custom_alert.dart';
import '../core/values/text_styles.dart';
import '../models/note.dart';
import '../utils/theme/theme_controller.dart';

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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/note-view',
              arguments: [Note(), "ADD NOTE", null]);
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _BodyUi(BuildContext context, ThemeController themeController) {
    return Consumer<NoteController>(
      builder: (BuildContext context, controller, Widget? child) {
        if (controller.notes.length == 0) {
          return Expanded(child: Center(child: Image.asset('assets/images/empty.png')));
        } else {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: controller.notes.length,
                itemBuilder: (BuildContext context, int index) => _noteItemView(
                    themeController,
                    context,
                    controller.notes[index],
                    index,
                    controller),
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, index.isEven ? 1.8 : 2.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _noteItemView(ThemeController themeController, BuildContext context,
      Note note, int index, NoteController noteController) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/note-view',
            arguments: [note, "DETAILS", index]);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                "Are your sure want to delete?",
                style: TextStyle(color: Color.fromARGB(255, 36, 36, 54)),
              ),
              content: Row(
                children: [
                  _ctmButton(
                      "CANCEL", context, noteController, note.id!, index),
                  Spacer(),
                  _ctmButton(
                      "CONFIRM", context, noteController, note.id!, index)
                ],
              ),
            );
          },
        );
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
              DateFormat('dd MMM yyy')
                  .format(DateTime.parse(note.creationDate!)),
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
            Spacer(),
            if (note.lastModified != null)
              Text(
                "Last modified on " +
                    DateFormat('dd MMM yyy')
                        .format(DateTime.parse(note.lastModified!)),
                style: lastModifiedDateTextStyle(themeController.isDarkTheme!),
              )
          ],
        ),
      ),
    );
  }

  Widget _ctmButton(String label, BuildContext context,
          NoteController controller, int id, int index) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )),
          onPressed: () async {
            if (label == "CONFIRM") {
              int? result = await controller.deleteNote(id, index);
              if (result > 0) {
                CustomAlert.successAlert(
                    context: context,
                    title: "Deleted",
                    body: "Your note deleted permanently.");
              } else {
                CustomAlert.errorAlert(
                    context: context,
                    title: "Failed to delete",
                    body: "Something went wrong.");
              }
            }
            Navigator.pop(context);
          },
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ));

  Widget _AppBar(BuildContext context, ThemeController themeController) {
    return Container(
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _kDarkModeButton(themeController),
          Spacer(),
          Text(
            "Cubit Notes",
            style: appBarTextStyle(themeController.isDarkTheme!),
          ),
          Spacer(),
          // IconButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/note-view',
          //           arguments: [Note(), "ADD NOTE", null]);
          //     },
          //     icon: Icon(Icons.add))
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
      child: Center(
        child: Icon(
          themeController.isDarkTheme! ? Icons.dark_mode : Icons.sunny,
          color: themeController.isDarkTheme! ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
