import 'package:flutter/material.dart';
import 'package:ghena_alshaam/modules/main_screens/intro/units/curve_image.dart';
import 'package:ghena_alshaam/modules/widgets/drawer_page_stack.dart';
import 'package:ghena_alshaam/modules/widgets/home_video.dart';

import 'units/intro_icon.dart';


class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    return DrawPageStack(
      backgroundAssets: 'assets/images/home.png',
      body: Stack(
        children: const <Widget>[
          HomeVideo(),
          CurveImage(),
          IntroIconButton(),
        ],
      ),
      video: const HomeVideo(),
    );
  }
}
