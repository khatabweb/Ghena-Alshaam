import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomButton extends StatefulWidget {
  final double? width, height, opacity, radius, topPadding, bottomPadding, rightPadding, leftPadding, horizontalPadding, fontSize;
  final String? text;
  final Color? color, textColor, borderColor;
  final FontWeight? fontWeight;
  final Widget? title;
  final VoidCallback? onTap;
  final bool? isFrame;
  final String? fontFamily;
  const CustomButton(
      {Key? key, this.width,
        this.height,
        this.text,
        this.opacity,
        this.radius,
        this.topPadding,
        this.bottomPadding,
        this.rightPadding,
        this.leftPadding,
        this.color,
        this.textColor,
        this.fontWeight,
        this.title,
        this.fontSize,
        this.onTap,
        this.horizontalPadding,
        this.isFrame, this.borderColor, this.fontFamily}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height ?? 45,
        padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 0),
        margin: EdgeInsets.only(
          bottom: widget.bottomPadding ?? 8,
          top: widget.topPadding ?? 8,
          left: widget.leftPadding ?? 0,
          right: widget.rightPadding ?? 0,
        ),
        decoration: BoxDecoration(
          color: widget.isFrame == true ? Colors.white : (widget.color ?? kPrimaryColor),
          borderRadius: BorderRadius.circular(widget.radius ?? 5),
          border: Border.all(color: widget.isFrame == true ? kPrimaryColor : (widget.borderColor ?? Colors.transparent)),
        ),
        child: Center(
          child: widget.text == null
              ? widget.title
              : Text(
            widget.text ?? "",
            style: TextStyle(
                color: widget.isFrame == true || widget.color == Colors.white
                    ? (widget.textColor ?? kPrimaryColor)
                    : (widget.textColor ?? Colors.white),
                fontSize: widget.fontSize ?? 14,
                fontWeight: widget.fontWeight ?? FontWeight.bold,
                fontFamily: widget.fontFamily ?? "cairo",
            ),
            ),
          ),
        ),
    );
  }
}