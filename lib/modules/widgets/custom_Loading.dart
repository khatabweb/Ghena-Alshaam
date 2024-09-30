import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.15,
        child: const FlareActor(
          "assets/flare/internet_loading.flr",
          fit: BoxFit.cover,
          animation: "loading",
          color: kPrimaryColor,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}