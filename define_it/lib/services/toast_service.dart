import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  /// Show a toast message with optional error styling
  static void showToast(
    String message, {
    bool isError = false,
    Color? backgroundColor,
  }) {
    Fluttertoast.showToast(
      msg: message,                     // The message to display in the toast
      toastLength: Toast.LENGTH_SHORT,  // Duration of the toast (short or long)
      gravity: ToastGravity.BOTTOM,     // Position of the toast on the screen (bottom, center, top)
      backgroundColor:
          backgroundColor ?? (isError ? Colors.redAccent : Colors.blueAccent),
      textColor: Colors.white,
    );
  }

  /// Show an error toast with red background
  static void showError(String message) {
    showToast(message, isError: true);
  }
}