import 'package:cubit_note/core/values/app_colors.dart';
import 'package:cubit_note/core/values/app_values.dart';
import 'package:cubit_note/core/values/text_styles.dart';
import 'package:cubit_note/modules/note_view_add_edit/controllers/note_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../utils/theme/theme_controller.dart';

class NoteViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final noteViewController = Provider.of<NoteViewController>(context, listen: false);
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
                      _labelTextField(noteViewController),
                      AppValues.spaceH20,
                      _bodyTextField(noteViewController),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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

  TextFormField _bodyTextField(NoteViewController noteViewController) {
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

  TextFormField _labelTextField(NoteViewController noteViewController) {
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
          Spacer(),
          _editButton()
        ],
      ),
    );
  }

  Widget _editButton() {
    return Container(
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 235, 235, 235),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Row(
            children: [
              Icon(Icons.edit, size: 18),
              AppValues.spaceH10,
              Text("EDIT"),
            ],
          )),
    );
  }
}
