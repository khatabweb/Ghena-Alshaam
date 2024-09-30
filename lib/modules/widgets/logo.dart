import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8, top: 28,),
      child: CircleAvatar(
        radius: 64.0,
        backgroundColor: Colors.transparent,
        backgroundImage: ExactAssetImage('assets/images/whitelogo.png'),
      ),
    );
  }
}
