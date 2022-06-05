import 'package:bwc_test/main.dart';
import 'package:flutter/material.dart';


class NotificationUtils {
  static void showSnackbar(String message,
      {Color backgroundColor = Colors.green, SnackBarAction? action}) {
    scaffoldMessengerState.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        action: action,
        content: Text(message),
      ),
    );
  }

}
