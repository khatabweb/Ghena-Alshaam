import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_offer_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/model/offers_model.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/custom_button.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';

import '../../../../modules/widgets/custom_text.dart';
import '../widgets/make_offer_form.dart';
import '../widgets/quantity_widget.dart';

class OffersDetailsView extends StatelessWidget {
  final Data? offer;
  const OffersDetailsView({Key? key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cubit = MakeOfferCubit.of(context);
    print(offer?.toJson());
    return Scaffold(
      appBar: customAppBar(context, 'تفاصيل العرض',
          showArrowBackIcon: true, showCart: false, showLogo: false),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// offer image
                Container(
                  height: screenSize.height / 5,
                  width: screenSize.width,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage("https://ghinaanalshshama.com/public/dash/assets/img/${offer?.image}"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                MainText(text: "${offer?.desc}", fontSize: 16, verticalPadding: 15),

                OfferDetailsQuantity(price: offer?.price),
                SizedBox(height: 15),

                MakeOfferForm(),


                BlocBuilder<MakeOfferCubit, BaseState>(
                  builder: (context, state){
                    return state is LoadingState
                        ? CustomLoading()
                        : CustomButton(
                            width: MediaQuery.of(context).size.width,
                            text: "إتمام الشراء",
                            bottomPadding: 25,
                            topPadding: 15,
                            onTap: () {
                              cubit.cityId == null
                                  ? showSnackBar(context, "فضلا قم بإدخال المدينة")
                                  : cubit.payment_type == null
                                  ? showSnackBar(context, "فضلا قم بإدخال وسيلة الدفع")
                                  : cubit.lat == null
                                  ? showSnackBar(context, "فضلا قم بإدخال موقعك الحالي")
                                  : cubit.onMakeOffer(context, offer?.id, offer?.price);
                            },
                          );
                    },
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}