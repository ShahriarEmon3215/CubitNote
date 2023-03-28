import 'package:flutter/cupertino.dart';

class NoteViewController extends ChangeNotifier{
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();
}