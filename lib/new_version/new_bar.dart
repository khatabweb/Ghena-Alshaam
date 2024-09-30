import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';

import '../core/state/base_state.dart';
import '../modules/bloc/cubit/slider_text_cubit.dart';
import '../modules/widgets/custom_Loading.dart';

class NewsBar extends StatelessWidget {
  const NewsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderTextCubit, BaseState>(
      builder: (context, state) {
        return state is LoadingState
            ? SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: CustomLoading()),
              )
            : SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Marquee(
                  text:
                      "${SliderTextCubit.of(context).model?.data ?? "احدث العروض"}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: "Cairo"),
                  scrollAxis: Axis.horizontal,
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  textScaleFactor: 1,
                  pauseAfterRound: const Duration(seconds: 0),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 0),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 0),
                  decelerationCurve: Curves.easeOut,
                ),
              );
      },
    );
  }
}
