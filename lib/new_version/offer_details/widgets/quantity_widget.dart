import 'package:flutter/material.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_offer_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';

import '../../../constant.dart';

class OfferDetailsQuantity extends StatefulWidget {
  final int? price;
  const OfferDetailsQuantity({Key? key, this.price}) : super(key: key);

  @override
  State<OfferDetailsQuantity> createState() => _OfferDetailsQuantityState();
}

class _OfferDetailsQuantityState extends State<OfferDetailsQuantity> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final cubit = MakeOfferCubit.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => qty = qty + 1);
                    cubit.qty = qty;
                    print("qty ${cubit.qty}");
                  },
                  child: const CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    radius: 12,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                MainText(
                  text: "${qty}",
                  horizontalPadding: 10,
                  fontSize: 18,
                ),
                GestureDetector(
                  onTap: () {
                    if (qty > 1) {
                      setState(() => qty = qty - 1);
                    } else {
                      setState(() => qty = 1);
                    }
                    cubit.qty = qty;
                    // cubit.finalPrice = "${qty * widget.price!}";
                    print("qty ${cubit.qty}");
                    // print("Final price ${cubit.finalPrice}");
                  },
                  child: const CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    radius: 12,
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            MainText(
              textDirection: TextDirection.rtl,
              text: "${qty * widget.price!} ر.س",
              horizontalPadding: 10,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
