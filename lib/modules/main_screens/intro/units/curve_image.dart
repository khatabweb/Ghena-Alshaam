import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

double? screenWidth;
double? screenHeight;

class CurveImage extends StatelessWidget {
  const CurveImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: OvalTopBorderClipper(),
        child: Container(
          alignment: Alignment.topCenter,
          width: screenWidth,
          height: screenHeight! * 0.50,
          decoration: const BoxDecoration(
            image: DecorationImage(image: ExactAssetImage('assets/images/back.jpeg'),fit: BoxFit.fill),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.white,
          ),
         // child: const IntroIconButton(),
        ),
      ),
    );
  }
}
