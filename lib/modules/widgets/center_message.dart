import 'package:flutter/material.dart';
import '../../constant.dart';
import 'custom_text.dart';

class CenterMessage extends StatelessWidget {
  final String msg;
  final Color? textColor;

  const CenterMessage(this.msg, {Key? key, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleText(text: msg, color: textColor ?? kPrimaryColor),
    );
  }
}
