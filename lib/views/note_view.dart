import 'package:cubit_note/core/helpers/custom_alert.dart';
import 'package:cubit_note/core/values/app_colors.dart';
import 'package:cubit_note/core/values/app_values.dart';
import 'package:cubit_note/core/values/text_styles.dart';
import 'package:cubit_note/db_helper/sqfile_database.dart';
import 'package:cubit_note/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../utils/theme/theme_controller.dart';
import '../controllers/home_controller.dart';

class NoteViewScreen extends StatefulWidget {
  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  var isDataFetched = false;
  String? title = "";
  NoteController? noteController;
  int? index;
  var themeController;
  var args;
  Size? size;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isDataFetched) {
      themeController = Provider.of<ThemeController>(context);
      noteController = Provider.of<NoteController>(context, listen: false);
      size = MediaQuery.of(context).size;
      args = ModalRoute.of(context)!.settings.arguments as List;
      noteController!.titleController.text = args[0].title ?? "";
      noteController!.bodyController.text = args[0].body ?? "";
      title = args[1];
      if (title == "DETAILS") {
        index = args[2];
      }
      isDataFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          height: size!.height,
          child: Column(children: [
            _AppBar(context, themeController, title!),
            AppValues.spaceH20,
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _labelTextField(noteController!),
                      AppValues.spaceH20,
                      _bodyTextField(noteController!),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async => _onClickHandler(noteController!),
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

  _onClickHandler(
    NoteController noteController,
  ) async {
    if (title == "ADD NOTE") {
      int? result = await noteController!.insertNote(Note(
        title: noteController.titleController.text,
        body: noteController.bodyController.text,
        creationDate: DateTime.now().toString(),
        lastModified: DateTime.now().toString(),
      ));

      if (result > 0) {
        CustomAlert.successAlert(
            context: context,
            title: "Saved",
            body: "Your note saved successfully.");
      } else {
        CustomAlert.errorAlert(
            context: context, title: "Failed", body: "Something went wrong.");
      }
    }
    if (title == "DETAILS") {
      int? result = await noteController!.updateNote(
          Note(
            id: args[0].id,
            title: noteController.titleController.text,
            body: noteController.bodyController.text,
            creationDate: args[0].creationDate,
            lastModified: DateTime.now().toString(),
          ),
          index!);

      if (result > 0) {
        CustomAlert.successAlert(
            context: context,
            title: "Updated",
            body: "Your note updated successfully.");
      } else {
        CustomAlert.errorAlert(
            context: context, title: "Failed", body: "Something went wrong.");
      }
    }
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

  Widget _AppBar(
      BuildContext context, ThemeController themeController, String title) {
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
            title,
            style: appBarTextStyle(themeController.isDarkTheme!),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
