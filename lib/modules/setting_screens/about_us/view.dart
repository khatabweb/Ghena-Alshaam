import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/about_us_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/cutom_network_image.dart';
import 'package:ghena_alshaam/modules/widgets/home_video.dart';

import '../../../new_version/new_bar.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => AboutUsCubit()..onGetAbout(context),
      child: Scaffold(
        appBar: customAppBar(context, 'تعرف علينا',
            showArrowBackIcon: false, showCart: true, showLogo: true),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(getImage('back.jpg')),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: const HomeVideo(),
              ),
              Expanded(
                child: BlocBuilder<AboutUsCubit, BaseState>(
                  builder: (context, state) {
                    final cubit = AboutUsCubit.of(context);
                    return state is LoadingState
                        ? const CustomLoading()
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.aboutModel?.data?.about?.length,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 15,
                            ),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: AppNetworkImage(
                                  imageUrl:
                                      "https://ghinaanalshshama.com/public/images/${cubit.aboutModel?.data?.about?[index]?.file}",
                                ),
                              );
                              // Container(
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(5),
                              //       image: DecorationImage(
                              //         image: NetworkImage(
                              //             "https://ghinaanalshshama.com/public/images/${cubit.aboutModel?.data?.about?[index]?.file}"),
                              //         fit: BoxFit.cover,
                              //       )),
                              // );
                            },
                          );
                  },
                ),
              ),
              NewsBar()
            ],
          ),
        ),
      ),
    );
  }
}
