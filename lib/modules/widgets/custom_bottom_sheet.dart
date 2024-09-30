import 'package:flutter/material.dart';

void customSheet({BuildContext? context, Widget? widget, double? height}) {
  showModalBottomSheet(
    context: context!,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) {
      return Container(
        color: const Color(0xFF737373),
        child: Container(
          padding: const EdgeInsets.only(top: 26),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width / 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: widget,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}