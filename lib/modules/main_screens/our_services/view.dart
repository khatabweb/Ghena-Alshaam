import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/all_services_cubit.dart';
import 'package:ghena_alshaam/modules/main_screens/sub_service/view.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/center_message.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/product_card/product_card.dart';

class OurServicesView extends StatelessWidget {
  const OurServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => AllServicesCubit()..onGetAllServices(context),
      child: Scaffold(
        appBar: customAppBar(
          context,
          'خدماتنا',
          showArrowBackIcon: true,
        ),
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(getImage('back.jpg')),
            ),
          ),
          child: BlocBuilder<AllServicesCubit, BaseState>(
            builder: (context, state) {
              final cubit = AllServicesCubit.of(context);
              return state is LoadingState
                  ? const CustomLoading()
                  : cubit.allServicesModel?.data?.services?.isEmpty == true
                      ? const CenterMessage("لا توجد خدمات حاليا")
                      : GridView.builder(
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
                        );
            },
          ),
        ),
      ),
    );
  }
}
