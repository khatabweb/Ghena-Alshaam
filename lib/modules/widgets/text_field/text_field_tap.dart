import 'package:flutter/material.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import '../../../constant.dart';


class CustomTextFieldTap extends StatelessWidget {
  final String? label;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final Widget? icon;
  final double? horizontalPadding, verticalPadding, height;
  final Color? color;
  final Color? hintColor;
  final double? width;
  final double? labelSize;
  final String? fontFamily;

  const CustomTextFieldTap({
    Key? key,
    this.label,
    this.prefixIcon,
    this.onTap,
    this.icon,
    this.horizontalPadding,
    this.verticalPadding,
    this.height,
    this.color,
    this.hintColor,
    this.width,
    this.labelSize,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 0),
        padding: const EdgeInsets.only(right: 10, top: 10.0, bottom: 10.0, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color ?? Colors.transparent,
          border: Border.all(color: kLightTextColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 0),
                    child: prefixIcon,
                  ),
                  Expanded(
                    child: SingleText(
                      text: label ?? "",
                      maxLines: 1,
                      fontSize: labelSize ?? 12,
                      color: hintColor ?? kPrimaryColor,
                      fontFamily: fontFamily,
                    ),
                  )
                ],
              ),
            ),
            icon ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: kLightTextColor,
                ),
          ],
        ),
      ),
    );
  }
}