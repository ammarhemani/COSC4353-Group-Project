import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showWarningSnackBar(BuildContext context, String text) {
    if (text.isNotEmpty) {
      Flushbar(
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          borderRadius: BorderRadius.circular(8),
          messageText: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          icon: const Icon(
            Icons.warning,
            color: Colors.yellow,
          )).show(context);
    }
  }

  static void showGenericErrorSnackBar(BuildContext context) {
    showSnackBar(
        context,
        'Oops, something went wrong..',
        Icon(
          Icons.error_outline,
          color: Colors.red,
        ));
  }

  static void showSnackBar(BuildContext context, String text, Icon icon) {
    if (text.isNotEmpty) {
      Flushbar(
        duration: Duration(seconds: 3),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        borderRadius: BorderRadius.circular(8),
        messageText: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        icon: icon,
      ).show(context);
    } else {
      showGenericErrorSnackBar(context);
    }
  }
}
