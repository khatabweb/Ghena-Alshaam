import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
// import 'package:ghena_alshaam/modules/bloc/cubit/all_services_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/offers_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/center_message.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';

import '../../../modules/widgets/custom_text.dart';
import '../widgets/offer_widget.dart';

class OffersView extends StatelessWidget {
  const OffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => OffersCubit()..onGetAllOffers(context),
      child: Scaffold(
        appBar: customAppBar(context, 'العروض',
            showArrowBackIcon: false, showCart: true, showLogo: true),
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage(getImage('back.jpg')),
              // ),
              ),
          child: BlocBuilder<OffersCubit, BaseState>(
            builder: (context, state) {
              final cubit = OffersCubit.of(context);
              return state is LoadingState
                  ? const CustomLoading()
                  : cubit.offersModel == null
                      ? Center(
                          child: MainText(
                          text: "حدث خطأ ما يرجي المحاولة مرة اخري",
                          fontSize: 15,
                        ))
                      : cubit.offersModel?.data?.isEmpty == true
                          ? const CenterMessage("لا توجد عروض حاليا")
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: cubit.offersModel?.data?.length,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 2,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (context, index) {
                                final ele = cubit.offersModel?.data?[index];
                                return OffersWidgets(
                                  image: ele!.image!,
                                  price: ele.price!.toString(),
                                  tittel: ele.desc!.toString(),
                                  data : ele,
                                );
                              },
                            );
            },
          ),
        ),
      ),
    );
  }
}
