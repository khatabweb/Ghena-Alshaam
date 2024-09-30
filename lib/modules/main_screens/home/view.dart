import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/slider_text_cubit.dart';
import 'package:ghena_alshaam/modules/main_screens/home/units/icons.dart';
import 'package:ghena_alshaam/modules/main_screens/intro/units/curve_image.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/setting_screens/drawer/drawer.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/drawer_page_stack.dart';
import 'package:ghena_alshaam/modules/widgets/home_video.dart';
import 'package:marquee/marquee.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SliderTextCubit()..onGetSliderText(context),
      child: DrawPageStack(
        scaffoldKey: _scaffoldKey,
        appBar: customAppBar(
          context,
          'الصفحة الرئيسية',
          showArrowBackIcon: false,
        ),
        backgroundAssets: 'assets/images/home.png',
        body: Stack(
          children: [
            const HomeVideo(),
            const CurveImage(),
            const HomeIcons(),
            Positioned(
              bottom: 10,
              child: BlocBuilder<SliderTextCubit, BaseState>(
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
                            text: "${SliderTextCubit.of(context).model?.data}",
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
                            decelerationDuration:
                                const Duration(milliseconds: 0),
                            decelerationCurve: Curves.easeOut,
                          ),
                        );
                },
              ),
            ),
          ],
        ),
        drawer: const CustomDrawer(),
        video: const HomeVideo(),
      ),
    );
  }
}
