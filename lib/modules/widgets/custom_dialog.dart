import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final Widget? contact;
  final Widget? titleWidget;

  const CustomDialog({Key? key, this.title,this.contact, this.titleWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      elevation: 30,
      title: titleWidget ?? MainText(text: title??"", textAlign: TextAlign.center, color: Theme.of(context).primaryColor, fontSize: 17),
      content: contact,
      // actions: actions as List<Widget>,
    );
  }
}