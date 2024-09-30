import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:ghena_alshaam/constant.dart';

// ignore: must_be_immutable
class SplashBody extends StatelessWidget {
  SplashBody({Key? key}) : super(key: key);

  double? screenHeight;
  double? mainLogoSize;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    mainLogoSize = screenHeight! * 0.142;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      color: kPrimaryColor,
      // decoration: _boxDecoration,
      child: Image.asset(
        "assets/images/logo.png",
        width: MediaQuery.of(context).size.width / 1.8,
        height: MediaQuery.of(context).size.width / 1.8,
        // fit: BoxFit.contain,
      ),
      // child: ,
    );
  }
}

/*
Stack(
      children: <Widget>[
        Container(
          decoration: _boxDecoration,
          child: Stack(
            children: <Widget>[
              _flare,
              _logo(mainLogoSize),
            ],
          ),
        ),
      ],
    )
 */
BoxDecoration _boxDecoration = const BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/splash.png'),
    fit: BoxFit.cover,
  ),
);

Widget _flare = const Center(
  child: FlareActor(
    "assets/flare/loading.flr",
    fit: BoxFit.cover,
    animation: "loading",
  ),
);

Widget _logo(double? mainLogoSize) => Center(
      child: CircleAvatar(
        backgroundImage: const AssetImage("assets/images/mainlogo.png"),
        backgroundColor: Colors.transparent,
        radius: mainLogoSize,
      ),
    );
