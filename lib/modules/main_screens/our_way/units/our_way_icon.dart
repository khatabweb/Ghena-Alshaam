import 'package:flutter/material.dart';

class OurWayIcon extends StatelessWidget {
  const OurWayIcon({Key? key}) : super(key: key);

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
              backgroundImage: ExactAssetImage('assets/icons/knife.png'),
            ),
            onPressed: () {}),
      ),
    );;
  }
}
