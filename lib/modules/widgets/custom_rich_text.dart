import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomRichText extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final double? fontSize;

  const CustomRichText({Key? key, this.title, this.subTitle, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title : ",
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize ?? 16,
              letterSpacing: 1,
              height: 2,
              fontWeight: FontWeight.w500,
              fontFamily: "cairo",
            ),
          ),
          TextSpan(
            text: subTitle,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: fontSize ?? 16,
              letterSpacing: 1,
              height: 2,
              fontWeight: FontWeight.bold,
              fontFamily: "cairo",
            ),
          ),
        ],
      ),
    );
    ;
  }
}