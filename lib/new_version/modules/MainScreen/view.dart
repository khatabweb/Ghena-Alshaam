import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/all_services_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/model/all_services_model.dart';
import 'package:ghena_alshaam/modules/main_screens/sub_service/view.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/center_message.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:ghena_alshaam/modules/widgets/cutom_network_image.dart';
import 'package:ghena_alshaam/modules/widgets/product_card/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:marquee/marquee.dart';

// import '../../../modules/bloc/cubit/slider_text_cubit.dart';
import '../../../modules/setting_screens/drawer/drawer.dart';
import '../../new_bar.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);
  final CarouselController buttonCarouselController = CarouselController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => AllServicesCubit()..onGetAllServices(context),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const CustomDrawer(),
        appBar: customAppBar(
          context,
          'الرئيسية',
          showArrowBackIcon: false,
          showCart: true,
          showLogo: true,
        ),
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: BlocBuilder<AllServicesCubit, BaseState>(
            builder: (context, state) {
              final cubit = AllServicesCubit.of(context);
              if (state is LoadingState) {
                return const CustomLoading();
              } else if (cubit.allServicesModel == null) {
                return Center(
                  child: MainText(
                    text: "حدث خطأ ما يرجي المحاولة مرة اخري",
                    fontSize: 15,
                  ),
                );
              } else if (cubit.allServicesModel?.data?.services?.isEmpty ==
                  true) {
                return const CenterMessage("لا توجد فئات حاليا");
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    _ads(context, cubit.allServicesModel?.data?.ads),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: MainText(text: "الفئات", fontSize: 20),
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount:
                            cubit.allServicesModel?.data?.services?.length,
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
                          final ele =
                              cubit.allServicesModel?.data?.services?[index];
                          return ProductCard(
                            name: ele?.name,
                            image: ele?.path,
                            onTap: () => NavigatorHelper.push(
                                context, SubServiceView(ele)),
                          );
                        },
                      ),
                    ),
                    NewsBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  _ads(context, List<Ads>? ads) {
    return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * .18,
        // aspectRatio: 16 / ,
        viewportFraction: 0.95,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: ads!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return AppNetworkImage(
              imageUrl:
                  "https://ghinaanalshshama.com/public/dash/assets/img/${i.ad!}",
              fit: BoxFit.contain,
            );
            // Container(
            //   // width: width * 0.4,
            //   // height: width * 0.3,
            //   height: MediaQuery.of(context).size.height * .18,
            //   width: MediaQuery.of(context).size.width,
            //   margin: EdgeInsets.all(2),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(8),
            //       topRight: Radius.circular(8),
            //     ),
            //     color: Colors.white,
            //     image: DecorationImage(
            //       image: NetworkImage(
            //         "https://ghinaanalshshama.com/public/dash/assets/img/${i.ad!}",
            //       ),
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            //   // child: Text('$index'),
            // );
          },
        );
      }).toList(),
    );
  }
}
