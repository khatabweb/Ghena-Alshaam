import 'package:flutter/material.dart';

import '../../constant.dart';


class SingleText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final double? textHeight;
  final Color? color;
  final String? fontFamily;
  final TextDirection? textDirection;
  final double? horizontalPadding;
  final double? verticalPadding;
  final TextDecoration? decoration;
  final int? maxLines;

  const SingleText({
    Key? key,
    required this.text,
    this.textAlign,
    this.fontSize,
    this.color,
    this.fontFamily,
    this.textDirection,
    this.textHeight, this.horizontalPadding, this.verticalPadding, this.decoration, this.maxLines,
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 0),
      child: Text(
        text??"",
        textAlign: textAlign,
        textDirection: textDirection,
        maxLines: maxLines,
        style: TextStyle(
          height: textHeight,
          fontSize: fontSize ?? 16,
          color: color ?? kTextColor,
          fontFamily: "cairo",
          decoration: decoration,
        ),
      ),
    );
  }
}




class MainText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final double? horizontalPadding;
  final double? verticalPadding;
  final TextDecoration? decoration;
  final int? maxLines;

  const MainText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.textAlign,
    this.textDirection, this.horizontalPadding, this.verticalPadding, this.decoration, this.maxLines,
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 0),
      child: Text(
        text??"",
        textAlign: textAlign ?? TextAlign.start,
        textDirection: textDirection,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: fontSize ?? 22,
          color: color ?? kTextColor,
          fontWeight: FontWeight.w700,
          fontFamily: "cairo",
          decoration: decoration,
        ),
      ),
    );
  }
}
