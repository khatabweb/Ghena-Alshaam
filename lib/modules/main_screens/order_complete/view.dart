import 'package:flutter/material.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
import 'package:ghena_alshaam/modules/widgets/custom_button.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

import '../../Navigation.dart';

class OrderCompletedView extends StatelessWidget {
  const OrderCompletedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 36),
          decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage(getImage('back.jpg'))
              // )
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/done.json",
                  height: 200, width: 200, fit: BoxFit.cover),
              const MainText(text: "تم الشراء بنجاح", verticalPadding: 25),
              const SizedBox(height: 25),
              CustomButton(
                text: "إستكمال الشراء",
                onTap: () =>
                    NavigatorHelper.pushReplacement(context, Navigation()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
