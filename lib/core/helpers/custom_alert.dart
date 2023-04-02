import 'package:flutter/material.dart';
import 'package:smart_snackbars/enums/animate_from.dart';
import 'package:smart_snackbars/smart_snackbars.dart';

class CustomAlert {
  static void successAlert(
      {required BuildContext context, String? title, String? body}) {
    SmartSnackBars.showTemplatedSnackbar(
      context: context,
      backgroundColor: Colors.green,
      animateFrom: AnimateFrom.fromTop,
      leading: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.2),
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      titleWidget: Text(
        title!,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subTitleWidget: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          body!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      trailing: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }

  static void errorAlert(
      {required BuildContext context, String? title, String? body}) {
    SmartSnackBars.showTemplatedSnackbar(
      context: context,
      backgroundColor: Colors.red,
      animateFrom: AnimateFrom.fromTop,
      leading: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.2),
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      titleWidget: Text(
        title!,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subTitleWidget: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          body!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      trailing: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }
}
