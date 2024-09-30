import 'package:flutter/material.dart';
import 'package:ghena_alshaam/modules/main_screens/home/view.dart';

class IntroIconButton extends StatelessWidget {
  const IntroIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 0.408),
      child: Align(
        alignment: Alignment.center,
        child: IconButton(
            iconSize: 60.0,
            icon: const CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.transparent,
              backgroundImage: ExactAssetImage('assets/icons/home_icon.png'),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  Home()), (Route<dynamic> route) => false);
            }),
      ),
    );
  }
}
