import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_order_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/custom_bottom_sheet.dart';
import 'package:ghena_alshaam/modules/widgets/custom_button.dart';
import 'package:ghena_alshaam/modules/widgets/custom_rich_text.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';

import '../../../constant.dart';

void payBottomSheet(BuildContext context,
    {String? productName, int? productId, int? qty, String? price}) {
  customSheet(
    context: context,
    widget: Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const MainText(
                text: "معلومات الطلب",
                fontSize: 16,
                color: kPrimaryColor,
                verticalPadding: 10),
            SingleText(
              text: "لقد قمت بشراء $productName",
              fontSize: 16,
              textAlign: TextAlign.center,
              verticalPadding: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRichText(
                  title: "الكمية",
                  subTitle: "$qty",
                ),
                CustomRichText(
                  title: "السعر",
                  subTitle: "${qty! * int.parse("$price")} ر.س",
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: BlocBuilder<MakeOrderCubit, BaseState>(
                builder: (context, state) {
                  return state is LoadingState
                      ? const CustomLoading()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              width: MediaQuery.of(context).size.width / 2.3,
                              text: "إلغاء الطلب",
                              isFrame: true,
                              onTap: () => MakeOrderCubit.of(context).cleanData(),
                            ),
                            CustomButton(
                              width: MediaQuery.of(context).size.width / 2.3,
                              text: "إتمام الشراء",
                              // onTap: () => MakeOrderCubit.of(context).onMakeOrder(context, productId, qty),
                            ),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
