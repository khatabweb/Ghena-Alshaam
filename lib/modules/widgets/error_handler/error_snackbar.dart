import 'package:flutter/material.dart';

void showSnackBar(BuildContext? context, String error, {bool? isSuccess = false}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      backgroundColor: isSuccess == true ? Colors.green : Colors.red,
      content: Text(
        error,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontFamily: "cairo",
        ),
      ),
    ),
  );
}