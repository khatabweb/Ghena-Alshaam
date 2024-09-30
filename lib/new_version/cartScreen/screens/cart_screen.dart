import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_order_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';

import '../../../core/navigation/custom_navigator.dart';
import '../../../modules/widgets/center_message.dart';
import '../../../modules/widgets/custom_button.dart';
import '../widgets/cart_item_widget.dart';
import 'Confirm_order.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);
  double total = 0.0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customAppBar(
        context,
        'السلة',
        showArrowBackIcon: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(getImage('back.jpg')),
          fit: BoxFit.cover,
        )),
        child: BlocBuilder<MakeOrderCubit, BaseState>(
          builder: (context, state) {
            final cubit = MakeOrderCubit.of(context);
            total = 0.0;

            print(cubit.cartItems);

            if(cubit.cartItems.isNotEmpty){
              for (int i = 0; i < cubit.cartItems.length; i++) {
                total += (cubit.cartItems[i].qty! * double.parse(cubit.cartItems[i].price!));
              }
            }
            return state is LoadingState
                ? const CustomLoading()
                : cubit.cartItems.isEmpty
                    ? CenterMessage("لا توجد منتجات حاليا")
                    : Column(
                        children: [
                          /// products list
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cubit.cartItems.length,
                              itemBuilder: (context, index) {
                                var ele = cubit.cartItems[index];
                                return CartItemWidget(
                                  index: index,
                                  qty: ele.qty,
                                  productId: ele.productId,
                                  image: ele.image,
                                  name: ele.name,
                                  packaging: ele.packaging,
                                  price: ele.price,
                                  shredder: ele.shredder,
                                );
                              },
                            ),
                          ),

                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  MainText(text: "المجموع : "),
                                  MainText(text: "${total}"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .8,
                            child: CustomButton(
                              text: "إتمام الطلب",
                              topPadding: 20,
                              bottomPadding: 20,
                              onTap: () {
                                NavigatorHelper.push(
                                    context, ConfirmOrderView());
                              },
                            ),
                          ),
                        ],
                      );
          },
        ),
      ),
    );
  }
}
