import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

void customDialog(BuildContext context, String error, {String? buttonText, VoidCallback? onPressed}){
  showCupertinoDialog(context: context, builder: (_){
    return CupertinoAlertDialog(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "cairo",
              color: kDarkTextColor,
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: onPressed ?? () => Navigator.pop(context),
            child: Text(
              buttonText ?? "موافق",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: kTextColor,
              ),
            ),
          ),
        ],
      );
  });
}