import 'package:cubit_note/core/values/app_colors.dart';
import 'package:cubit_note/core/values/app_values.dart';
import 'package:cubit_note/core/values/text_styles.dart';
import 'package:cubit_note/db_helper/sqfile_database.dart';
import 'package:cubit_note/modules/home/controllers/home_controller.dart';
import 'package:cubit_note/modules/note_view_add_edit/controllers/note_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/note.dart';
import '../../../utils/theme/theme_controller.dart';
import '../../home/controllers/home_controller.dart';

class NoteViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final noteController = Provider.of<NoteController>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Column(children: [
            _AppBar(context, themeController),
            AppValues.spaceH20,
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _labelTextField(noteController),
                      AppValues.spaceH20,
                      _bodyTextField(noteController),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          noteController.insertNote(Note(
            title: noteController.titleController.text,
            body: noteController.bodyController.text,
            creationDate: DateTime.now().toString(),
            lastModified: DateTime.now().toString(),
          ));
        },
        label: Text(
          "Save",
          style: titleTextStyle(themeController.isDarkTheme!),
        ),
        backgroundColor: AppColors.green,
        icon: Icon(Icons.save,
            color: themeController.isDarkTheme! ? Colors.white : Colors.black),
      ),
    );
  }

  TextFormField _bodyTextField(NoteController noteViewController) {
    return TextFormField(
      controller: noteViewController.bodyController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration.collapsed(
        hintText: "Type here...",
      ),
      style: TextStyle(
        fontSize: 22.0,
      ),
    );
  }

  TextFormField _labelTextField(NoteController noteViewController) {
    return TextFormField(
      maxLines: null,
      controller: noteViewController.titleController,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration.collapsed(
        hintText: "Title",
      ),
      style: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w500,
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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)), 
          Spacer(),
          Text(
            "Note Details",
            style: appBarTextStyle(themeController.isDarkTheme!),
          ),
        ],
      ),
    );
  }


}
