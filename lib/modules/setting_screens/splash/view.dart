import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:ghena_alshaam/modules/main_screens/intro/view.dart';
import 'package:ghena_alshaam/modules/setting_screens/splash/units/splash_body.dart';

import '../../Navigation.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Duration _duration = const Duration(seconds: 6);
  Timer? _time;
  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  dispose() {
    startTime();
    _time!.cancel();
    super.dispose();
  }

  startTime() async {
    _time = Timer(_duration, navigationScreen);
    // return null;
  }

  void navigationScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Navigation()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBody(),
    );
  }
}
