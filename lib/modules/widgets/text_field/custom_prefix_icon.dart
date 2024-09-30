import 'package:flutter/material.dart';

class CustomPrefixIcon extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final Color? color;
  const CustomPrefixIcon(this.image, {Key? key, this.width, this.height, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 20,
      height: height,
      color: Colors.transparent,
      child: Center(child: Image.asset(image, fit: BoxFit.contain, height: 15, width: 15, color: color)),
    );
  }
}
