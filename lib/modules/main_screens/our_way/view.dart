import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/our_way_cubit.dart';

import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:ghena_alshaam/modules/widgets/drawer_page_stack.dart';
import '../../../constant.dart';

class OurWayView extends StatelessWidget {
  const OurWayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => OurWayCubit()..onGetOurWay(context),
      child: DrawPageStack(
        backgroundAssets: 'assets/images/ourway.png',
        appBar: customAppBar(
          context,
          'طريقتنا',
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.topCenter,
                width: width,
                height: height * 0.65,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/images/back.jpeg'),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.transparent,
                ),
                child: BlocBuilder<OurWayCubit, BaseState>(
                  builder: (context, state) {
                    final cubit = OurWayCubit.of(context);
                    return state is LoadingState
                        ? const CustomLoading()
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                SingleText(
                                  text: "${cubit.ourWayModel?.data?[0]?.myWay}",
                                  textDirection: TextDirection.rtl,
                                  fontSize: 18.0,
                                  color: kTextColor,
                                ),
                              ],
                            ),
                          );
                  },
                ),
                // child: const IntroIconButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
